import 'package:flutter/material.dart';
import 'package:getpaid_client/getpaid_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../widgets.dart';
import 'invoice_detail_screen.dart';

/// Home: every invoice with its live status. Drafts can be sent from here.
class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  late Future<List<Invoice>> _future;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _future = client.invoice.listInvoices();
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
        title: const Text('GetPaid'),
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
      body: FutureBuilder<List<Invoice>>(
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
          final invoices = snap.data!;
          if (invoices.isEmpty) {
            return const Center(
              child: Text('No invoices yet.\nTap + to create your first one.'),
            );
          }
          return ListView.builder(
            itemCount: invoices.length,
            itemBuilder: (context, i) {
              final inv = invoices[i];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(
                    '${inv.number} · ${money(inv.amountCents, inv.currency)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Due ${inv.dueDate.toIso8601String().substring(0, 10)}',
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
        dueDate: DateTime.now().add(const Duration(days: 7)),
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
