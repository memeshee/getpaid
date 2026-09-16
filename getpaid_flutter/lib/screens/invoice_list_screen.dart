import 'package:flutter/material.dart';
import 'package:getpaid_client/getpaid_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../widgets.dart';
import 'invoice_detail_screen.dart';

/// Home: outstanding dashboard + every invoice with its live status.
/// Drafts can be sent from here.
class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  late Future<(_Invoices, _Customers)> _future;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _future = Future.wait([
        client.invoice.listInvoices(),
        client.invoice.listCustomers(),
      ]).then((r) => (r[0] as List<Invoice>, r[1] as List<Customer>));
    });
  }

  Future<void> _send(Invoice inv) async {
    try {
      await client.invoice.sendInvoice(inv.id!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${inv.number} sent — chase clock started')),
        );
      }
      _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Send failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('GetPaid'),
            Text(
              'Invoices that chase themselves',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await client.auth.signOutDevice();
            },
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: FutureBuilder<(_Invoices, _Customers)>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Could not reach the server.\nIs `dart bin/main.dart` running?\n\n${snap.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          final invoices = snap.data!.$1;
          final names = {
            for (final c in snap.data!.$2) c.id: c.name,
          };
          if (invoices.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.mark_email_read_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No invoices yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Create one, press Send, and the chase\n'
                      'runs itself: nudge → firm → final notice.\n'
                      'It stops the instant money arrives.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          final now = DateTime.now();
          final outstanding = invoices
              .where((i) => i.status != InvoiceStatus.paid)
              .fold<int>(0, (sum, i) => sum + i.amountCents);
          final overdue = invoices
              .where(
                (i) =>
                    i.status == InvoiceStatus.sent && i.dueDate.isBefore(now),
              )
              .length;
          final currency = invoices.isNotEmpty
              ? invoices.first.currency
              : 'USD';
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 88),
            itemCount: invoices.length + 1,
            itemBuilder: (context, i) {
              if (i == 0) {
                return _DashboardCard(
                  outstanding: money(outstanding, currency),
                  openCount: invoices
                      .where((i) => i.status != InvoiceStatus.paid)
                      .length,
                  overdueCount: overdue,
                );
              }
              final inv = invoices[i - 1];
              final isOverdue =
                  inv.status == InvoiceStatus.sent && inv.dueDate.isBefore(now);
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: statusColor(
                      inv.status,
                    ).withValues(alpha: 0.15),
                    child: Icon(
                      inv.status == InvoiceStatus.paid
                          ? Icons.check
                          : inv.status == InvoiceStatus.sent
                          ? Icons.schedule_send
                          : Icons.description_outlined,
                      color: statusColor(inv.status),
                    ),
                  ),
                  title: Text(
                    '${inv.number} · ${money(inv.amountCents, inv.currency)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    '${names[inv.customerId] ?? 'Client'} · '
                    'due ${inv.dueDate.toIso8601String().substring(0, 10)}'
                    '${isOverdue ? ' · OVERDUE' : ''}',
                    style: TextStyle(
                      color: isOverdue
                          ? Theme.of(context).colorScheme.error
                          : null,
                      fontWeight: isOverdue ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StatusPill(
                        text: inv.status.name.toUpperCase(),
                        color: statusColor(inv.status),
                      ),
                      if (inv.status == InvoiceStatus.draft) ...[
                        const SizedBox(width: 8),
                        FilledButton.tonal(
                          onPressed: () => _send(inv),
                          child: const Text('Send'),
                        ),
                      ],
                    ],
                  ),
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => InvoiceDetailScreen(invoiceId: inv.id!),
                      ),
                    );
                    _refresh();
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await showDialog<bool>(
            context: context,
            builder: (_) => const NewInvoiceDialog(),
          );
          if (created == true) _refresh();
        },
        icon: const Icon(Icons.add),
        label: const Text('Invoice'),
      ),
    );
  }
}

typedef _Invoices = List<Invoice>;
typedef _Customers = List<Customer>;

/// Outstanding money at a glance.
class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.outstanding,
    required this.openCount,
    required this.overdueCount,
  });
  final String outstanding;
  final int openCount;
  final int overdueCount;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 6),
      color: scheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Outstanding',
                    style: TextStyle(
                      color: scheme.onPrimaryContainer.withValues(alpha: 0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    outstanding,
                    style: TextStyle(
                      color: scheme.onPrimaryContainer,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$openCount open',
                  style: TextStyle(
                    color: scheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  overdueCount == 0
                      ? 'nothing overdue'
                      : '$overdueCount overdue',
                  style: TextStyle(
                    color: overdueCount == 0
                        ? scheme.onPrimaryContainer.withValues(alpha: 0.8)
                        : scheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Create-customer-if-needed + create-invoice in one dialog.
class NewInvoiceDialog extends StatefulWidget {
  const NewInvoiceDialog({super.key});

  @override
  State<NewInvoiceDialog> createState() => _NewInvoiceDialogState();
}

class _NewInvoiceDialogState extends State<NewInvoiceDialog> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _amount = TextEditingController();
  final _notes = TextEditingController();
  int _dueInDays = 7;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _amount.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final amount = double.tryParse(_amount.text.trim());
    if (_name.text.trim().isEmpty ||
        _email.text.trim().isEmpty ||
        amount == null ||
        amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name, email and a valid amount first')),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      final existing = await client.invoice.listCustomers();
      final match = existing.where((c) => c.email == _email.text.trim());
      final customer = match.isNotEmpty
          ? match.first
          : await client.invoice.createCustomer(
              name: _name.text.trim(),
              email: _email.text.trim(),
            );
      await client.invoice.createInvoice(
        customerId: customer.id!,
        amountCents: (amount * 100).round(),
        currency: 'USD',
        notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
        dueDate: DateTime.now().add(Duration(days: _dueInDays)),
        items: [
          InvoiceItemInput(
            description: _notes.text.trim().isEmpty
                ? 'Services rendered'
                : _notes.text.trim(),
            quantity: 1,
            unitPriceCents: (amount * 100).round(),
          ),
        ],
      );
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Create failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New invoice'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Client name'),
            ),
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Client email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _amount,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '\$ ',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            TextField(
              controller: _notes,
              decoration: const InputDecoration(
                labelText: 'What for? (one line)',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Due in:'),
                const SizedBox(width: 12),
                DropdownButton<int>(
                  value: _dueInDays,
                  items: const [
                    DropdownMenuItem(value: 7, child: Text('7 days')),
                    DropdownMenuItem(value: 14, child: Text('14 days')),
                    DropdownMenuItem(value: 30, child: Text('30 days')),
                  ],
                  onChanged: (v) =>
                      setState(() => _dueInDays = v ?? _dueInDays),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create'),
        ),
      ],
    );
  }
}
