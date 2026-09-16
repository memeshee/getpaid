import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'chase_logic.dart';

/// Real-time chase engine: fires at +3/+7/+14 days after send.
/// Idempotent by construction — [runChaseStep] skips tiers already sent,
/// so at-least-once delivery (documented Serverpod semantics) is safe.
class ChaseFutureCall extends FutureCall<ChasePayload> {
  Future<void> checkChase(Session session, ChasePayload? payload) async {
    await runChaseStep(
      session,
      now: DateTime.now(),
      onlyInvoiceId: payload?.invoiceId,
    );
  }
}
