import 'package:flutter/material.dart';
import 'package:getpaid_client/getpaid_client.dart';

/// Shared bits: money formatting + status pills.
String money(int cents, String currency) =>
    '$currency ${(cents / 100).toStringAsFixed(2)}';

Color statusColor(InvoiceStatus s) => switch (s) {
  InvoiceStatus.draft => Colors.grey,
  InvoiceStatus.sent => Colors.blue,
  InvoiceStatus.paid => Colors.green,
};

Color tierColor(ReminderTier t) => switch (t) {
  ReminderTier.nudge => Colors.blue,
  ReminderTier.firm => Colors.orange,
  ReminderTier.finalNotice => Colors.red,
};

String tierLabel(ReminderTier t) => switch (t) {
  ReminderTier.nudge => 'Nudge · day 3',
  ReminderTier.firm => 'Firm · day 7',
  ReminderTier.finalNotice => 'Final notice · day 14',
};

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

/// One timeline row: dot + card.
class TimelineRow extends StatelessWidget {
  const TimelineRow({
    super.key,
    required this.dotColor,
    required this.title,
    this.subtitle,
    this.badge,
  });
  final Color dotColor;
  final String title;
  final String? subtitle;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(height: 4),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            Container(width: 2, height: 28, color: Colors.grey.shade300),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      badge ?? const SizedBox.shrink(),
                    ],
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
