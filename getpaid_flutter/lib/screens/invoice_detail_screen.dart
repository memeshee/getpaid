import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getpaid_client/getpaid_client.dart';

import '../client.dart';
import '../widgets.dart';

/// The money shot: full invoice thread as a timeline — sent, every chase
/// touch with its tier, payments — plus the judge time-lapse controls.
class InvoiceDetailScreen extends StatefulWidget {
  const InvoiceDetailScreen({super.key, required this.invoiceId});
  final int invoiceId;

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  late Future<InvoiceThread> _future;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _future = client.invoice.getThread(widget.invoiceId);
    });
  }

  Future<void> _run(Future Function() action, String ok) async {
    setState(() => _busy = true);
    try {
      await action();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok)));
      }
      _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invoice thread')),
      body: FutureBuilder<InvoiceThread>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Load failed: ${snap.error}'));
          }
          final thread = snap.data!;
          final inv = thread.invoice;
          final paid = inv.status == InvoiceStatus.paid;
          final paidTotal = thread.payments.fold<int>(
            0,
            (sum, p) => sum + p.amountCents,
          );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Header card.
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              inv.number,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          StatusPill(
                            text: inv.status.name.toUpperCase(),
                            color: statusColor(inv.status),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${thread.client?.name ?? '—'} · ${money(inv.amountCents, inv.currency)}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (inv.notes != null && inv.notes!.isNotEmpty)
                        Text(inv.notes!),
                      const SizedBox(height: 4),
                      Text(
                        'Due ${inv.dueDate.toIso8601String().substring(0, 10)}'
                        '${paid ? ' · paid ${money(paidTotal, inv.currency)}' : ''}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'TIMELINE',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 8),
              TimelineRow(
                dotColor: Colors.grey,
                title: 'Invoice created',
                subtitle:
                    'Issued ${inv.issueDate.toIso8601String().substring(0, 10)}',
              ),
              if (inv.sentAt != null)
                TimelineRow(
                  dotColor: Colors.blue,
                  title: 'Sent — chase clock started',
                  subtitle: inv.sentAt!
                      .toIso8601String()
                      .substring(0, 16)
                      .replaceFirst('T', ' '),
                ),
              for (final r in thread.reminders)
                TimelineRow(
                  dotColor: r.status == ReminderStatus.sent
                      ? tierColor(r.tier)
                      : Colors.grey.shade300,
                  title: r.subject ?? tierLabel(r.tier),
                  subtitle: r.status == ReminderStatus.sent
                      ? 'Sent ${r.sentAt.toString().substring(0, 16)}'
                      : 'Skipped (paid)',
                  badge: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (r.simulated)
                        const StatusPill(
                          text: 'TIME-LAPSE',
                          color: Colors.purple,
                        ),
                      if (r.simulated) const SizedBox(width: 6),
                      StatusPill(
                        text: r.tier.name.toUpperCase(),
                        color: tierColor(r.tier),
                      ),
                      if (r.body != null && r.body!.isNotEmpty) ...[
                        const SizedBox(width: 6),
                        IconButton(
                          icon: const Icon(Icons.copy, size: 16),
                          tooltip: 'Copy reminder text',
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(
                                text: '${r.subject ?? ''}\n\n${r.body}',
                              ),
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Reminder text copied — paste it into any email to chase manually',
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              for (final p in thread.payments)
                TimelineRow(
                  dotColor: Colors.green,
                  title:
                      'Paid ${money(p.amountCents, inv.currency)} · ${p.receiptNo}',
                  subtitle:
                      '${p.method ?? 'transfer'} · ${p.paidAt.toString().substring(0, 16)}',
                ),
              const SizedBox(height: 16),
              // Action bar.
              if (inv.status == InvoiceStatus.draft)
                FilledButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _run(
                          () => client.invoice.sendInvoice(inv.id!),
                          'Sent — chase clock started',
                        ),
                  icon: const Icon(Icons.send),
                  label: const Text('Send invoice & start chase'),
                ),
              if (!paid && inv.status == InvoiceStatus.sent) ...[
                const Text('Judge time-lapse:'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [4, 8, 15].map((d) {
                    return FilledButton.tonal(
                      onPressed: _busy
                          ? null
                          : () => _run(
                              () => client.invoice.simulate(d),
                              'Advanced $d days — due touches sent',
                            ),
                      child: Text('+$d days'),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _run(
                          () => client.invoice.markPaid(
                            inv.id!,
                            amountCents: inv.amountCents,
                            method: 'bank_transfer',
                          ),
                          'Marked paid — receipt issued',
                        ),
                  icon: const Icon(Icons.check),
                  label: const Text('Mark paid (client paid)'),
                ),
              ],
              if (paid)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Settled. The chase stopped the moment money arrived — '
                      'no paying client ever gets dunned.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              if (_busy) ...[
                const SizedBox(height: 16),
                const Center(child: CircularProgressIndicator()),
              ],
            ],
          );
        },
      ),
    );
  }
}
