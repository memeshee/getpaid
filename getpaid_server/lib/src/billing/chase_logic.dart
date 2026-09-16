import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../generated/serverpod.dart' as gp;

/// Chase schedule: days after [sentAt] when each tier becomes due.
const Map<ReminderTier, int> chaseDelaysDays = {
  ReminderTier.nudge: 3,
  ReminderTier.firm: 7,
  ReminderTier.finalNotice: 14,
};

/// Copy shown to the freelancer for each tier (also stored on the Reminder).
String tierSubject(ReminderTier tier, Invoice invoice) => switch (tier) {
      ReminderTier.nudge =>
        'Friendly nudge: invoice ${invoice.number} due ${invoice.dueDate.toIso8601String().substring(0, 10)}',
      ReminderTier.firm =>
        'Overdue: invoice ${invoice.number} needs your attention',
      ReminderTier.finalNotice =>
        'Final notice: invoice ${invoice.number} + late fee applies',
    };

String tierBody(ReminderTier tier, Invoice invoice, Customer client) {
  final amount = (invoice.amountCents / 100).toStringAsFixed(2);
  final due = invoice.dueDate.toIso8601String().substring(0, 10);
  return switch (tier) {
    ReminderTier.nudge => 'Hi ${client.name},\n\nJust a friendly heads-up that '
        'invoice ${invoice.number} for ${invoice.currency} $amount is due on $due.\n\n'
        'Pay link / details in the original invoice. Thanks!',
    ReminderTier.firm => 'Hi ${client.name},\n\nInvoice ${invoice.number} for '
        '${invoice.currency} $amount was due on $due and is now overdue.\n\n'
        'Please pay this week so we can keep things smooth.',
    ReminderTier.finalNotice => 'Hi ${client.name},\n\nInvoice ${invoice.number} for '
        '${invoice.currency} $amount is 14+ days overdue (due $due).\n\n'
        'A late fee now applies per the invoice terms. Please pay within 48 hours '
        'to avoid further action.',
  };
}

/// Core chase step, shared by the real future call and simulate().
/// Sends every due-but-unsent touch for open invoices as of [now].
/// Returns the reminders that were sent.
Future<List<Reminder>> runChaseStep(
  Session session, {
  required DateTime now,
  int? onlyInvoiceId,
  bool simulated = false,
  String? ownerId,
}) async {
  final sent = <Reminder>[];

  final invoices = onlyInvoiceId != null
      ? await Invoice.db.find(
          session,
          where: (t) =>
              t.id.equals(onlyInvoiceId) & t.status.equals(InvoiceStatus.sent),
        )
      : await Invoice.db.find(
          session,
          where: (t) => ownerId == null
              ? t.status.equals(InvoiceStatus.sent)
              : t.status.equals(InvoiceStatus.sent) &
                  t.ownerId.equals(ownerId),
        );

  for (final invoice in invoices) {
    if (invoice.id == null || invoice.sentAt == null) continue;
    final client = await Customer.db.findById(session, invoice.customerId);
    if (client == null) continue;

    final existing = await Reminder.db.find(
      session,
      where: (t) => t.invoiceId.equals(invoice.id!),
    );
    final doneTiers = {
      for (final r in existing)
        if (r.status == ReminderStatus.sent) r.tier,
    };

    for (final tier in ReminderTier.values) {
      if (doneTiers.contains(tier)) continue;
      final dueAt =
          invoice.sentAt!.add(Duration(days: chaseDelaysDays[tier]!));
      if (now.isBefore(dueAt)) continue;

      final reminder = Reminder(
        invoiceId: invoice.id!,
        tier: tier,
        status: ReminderStatus.sent,
        dueAt: dueAt,
        sentAt: now,
        subject: tierSubject(tier, invoice),
        body: tierBody(tier, invoice, client),
        simulated: simulated,
      );
      await Reminder.db.insertRow(session, reminder);
      sent.add(reminder);
    }
  }
  return sent;
}

/// Typed access to this server's generated future-call dispatch.
gp.Serverpod pod(Session session) => session.serverpod as gp.Serverpod;

/// Schedule the three chase touches for an invoice (real-time path).
Future<void> scheduleChase(Session session, int invoiceId) async {
  final fc = pod(session).futureCalls;
  final payload = ChasePayload(invoiceId: invoiceId);
  await fc
      .callWithDelay(
        Duration(days: chaseDelaysDays[ReminderTier.nudge]!),
        identifier: _chaseId(invoiceId),
      )
      .chase
      .checkChase(payload);
  await fc
      .callWithDelay(
        Duration(days: chaseDelaysDays[ReminderTier.firm]!),
        identifier: _chaseId(invoiceId),
      )
      .chase
      .checkChase(payload);
  await fc
      .callWithDelay(
        Duration(days: chaseDelaysDays[ReminderTier.finalNotice]!),
        identifier: _chaseId(invoiceId),
      )
      .chase
      .checkChase(payload);
}

/// Cancel pending touches + mark unsent reminders skipped (on payment).
Future<void> cancelChase(Session session, int invoiceId) async {
  await pod(session).futureCalls.cancel(_chaseId(invoiceId));
  final pending = await Reminder.db.find(
    session,
    where: (t) =>
        t.invoiceId.equals(invoiceId) &
        t.status.equals(ReminderStatus.scheduled),
  );
  for (final r in pending) {
    await Reminder.db.updateRow(
      session,
      r.copyWith(status: ReminderStatus.skipped),
    );
  }
}

String _chaseId(int invoiceId) => 'chase-$invoiceId';
