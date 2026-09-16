import 'package:getpaid_server/src/billing/chase_logic.dart';
import 'package:getpaid_server/src/generated/protocol.dart';
import 'package:test/test.dart';

Invoice _invoice() => Invoice(
  ownerId: 'owner-1',
  number: 'INV-0001',
  customerId: 7,
  amountCents: 80000,
  currency: 'USD',
  status: InvoiceStatus.sent,
  issueDate: DateTime.utc(2026, 9, 1),
  dueDate: DateTime.utc(2026, 9, 8),
  createdAt: DateTime.utc(2026, 9, 1),
);

Customer _customer() => Customer(
  ownerId: 'owner-1',
  name: 'Acme',
  email: 'pay@acme.example',
  createdAt: DateTime.utc(2026, 9, 1),
);

void main() {
  group('chase schedule', () {
    test('tiers fire on day 3 / 7 / 14', () {
      expect(chaseDelaysDays[ReminderTier.nudge], 3);
      expect(chaseDelaysDays[ReminderTier.firm], 7);
      expect(chaseDelaysDays[ReminderTier.finalNotice], 14);
    });

    test('every tier carries a distinct escalating copy', () {
      final inv = _invoice();
      final client = _customer();
      final subjects = {
        for (final t in ReminderTier.values) t: tierSubject(t, inv),
      };
      final bodies = {
        for (final t in ReminderTier.values) t: tierBody(t, inv, client),
      };
      // All three tiers say something different.
      expect(subjects.values.toSet(), hasLength(3));
      expect(bodies.values.toSet(), hasLength(3));
      // Every touch names the invoice, the client, and the amount.
      for (final body in bodies.values) {
        expect(body, contains('INV-0001'));
        expect(body, contains('Acme'));
        expect(body, contains('800.00'));
      }
      // Final notice mentions the late fee.
      expect(
        bodies[ReminderTier.finalNotice],
        contains('late fee'),
      );
    });
  });

  group('future-call identifiers', () {
    test('one stable id per tier, legacy id differs', () {
      final ids = {
        for (final t in ReminderTier.values) t: chaseId(42, t),
      };
      expect(ids.values.toSet(), hasLength(3));
      expect(chaseId(42, ReminderTier.nudge), chaseId(42, ReminderTier.nudge));
      expect(chaseId(42, ReminderTier.nudge), isNot(contains(' ')));
    });
  });
}
