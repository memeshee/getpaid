import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'chase_logic.dart';

/// Invoices: create, send (starts the chase clock), track, get paid.
/// Every method requires sign-in; all data is scoped to the caller's
/// auth user id. The judge time-lapse lives here: [simulate] runs the
/// exact same [runChaseStep] core as the future calls, but with a
/// virtual clock — and only over the caller's own invoices.
class InvoiceEndpoint extends Endpoint {
  /// The caller's auth identity. Throws when anonymous.
  String _owner(Session session) {
    final auth = session.authenticated;
    if (auth == null) throw StateError('sign in first');
    return auth.userIdentifier;
  }

  Future<Invoice> _ownedInvoice(Session session, int invoiceId) async {
    final invoice = await Invoice.db.findById(session, invoiceId);
    if (invoice == null) throw StateError('invoice not found');
    if (invoice.ownerId != _owner(session)) {
      throw StateError('invoice not found');
    }
    return invoice;
  }

  Future<List<Customer>> listCustomers(Session session) async {
    return Customer.db.find(
      session,
      where: (t) => t.ownerId.equals(_owner(session)),
      orderBy: (t) => t.name,
    );
  }

  Future<Customer> createCustomer(
    Session session, {
    required String name,
    required String email,
    String? company,
  }) async {
    return Customer.db.insertRow(
      session,
      Customer(
        ownerId: _owner(session),
        name: name,
        email: email,
        company: company,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<List<Invoice>> listInvoices(Session session) async {
    return Invoice.db.find(
      session,
      where: (t) => t.ownerId.equals(_owner(session)),
      orderBy: (t) => t.createdAt.desc(),
    );
  }

  Future<Invoice> createInvoice(
    Session session, {
    required int customerId,
    required int amountCents,
    String currency = 'USD',
    String? notes,
    required DateTime dueDate,
    List<InvoiceItemInput>? items,
  }) async {
    final owner = _owner(session);
    final customer = await Customer.db.findById(session, customerId);
    if (customer == null || customer.ownerId != owner) {
      throw StateError('customer not found');
    }
    final count = await Invoice.db.count(
      session,
      where: (t) => t.ownerId.equals(owner),
    );
    final now = DateTime.now();
    final invoice = await Invoice.db.insertRow(
      session,
      Invoice(
        ownerId: owner,
        number: 'INV-${(count + 1).toString().padLeft(4, '0')}',
        customerId: customerId,
        amountCents: amountCents,
        currency: currency,
        notes: notes,
        status: InvoiceStatus.draft,
        issueDate: now,
        dueDate: dueDate,
        createdAt: now,
      ),
    );
    for (final item in items ?? []) {
      await InvoiceItem.db.insertRow(
        session,
        InvoiceItem(
          invoiceId: invoice.id!,
          description: item.description,
          quantity: item.quantity,
          unitPriceCents: item.unitPriceCents,
        ),
      );
    }
    return invoice;
  }

  /// Send the invoice: flips status, stamps the chase clock, schedules
  /// the three real-time touches (+3/+7/+14d).
  Future<Invoice> sendInvoice(Session session, int invoiceId) async {
    final invoice = await _ownedInvoice(session, invoiceId);
    if (invoice.status != InvoiceStatus.draft) {
      throw StateError('only draft invoices can be sent');
    }
    final sent = invoice.copyWith(
      status: InvoiceStatus.sent,
      sentAt: DateTime.now(),
    );
    await Invoice.db.updateRow(session, sent);
    await scheduleChase(session, invoiceId);
    return sent;
  }

  /// Full thread: invoice + client + items + reminders + payments.
  Future<InvoiceThread> getThread(Session session, int invoiceId) async {
    final invoice = await _ownedInvoice(session, invoiceId);
    final client = await Customer.db.findById(session, invoice.customerId);
    final items = await InvoiceItem.db.find(
      session,
      where: (t) => t.invoiceId.equals(invoiceId),
    );
    final reminders = await Reminder.db.find(
      session,
      where: (t) => t.invoiceId.equals(invoiceId),
      orderBy: (t) => t.dueAt,
    );
    final payments = await Payment.db.find(
      session,
      where: (t) => t.invoiceId.equals(invoiceId),
    );
    return InvoiceThread(
      invoice: invoice,
      client: client,
      items: items,
      reminders: reminders,
      payments: payments,
    );
  }

  /// Record payment: ledger row + receipt ref, status → paid,
  /// pending chase touches cancelled (never duns a paying client).
  Future<Payment> markPaid(
    Session session,
    int invoiceId, {
    required int amountCents,
    String? method,
  }) async {
    final invoice = await _ownedInvoice(session, invoiceId);
    if (invoice.status == InvoiceStatus.paid) {
      throw StateError('invoice already paid');
    }
    final existing = await Payment.db.count(
      session,
      where: (t) => t.invoiceId.equals(invoiceId),
    );
    final payment = await Payment.db.insertRow(
      session,
      Payment(
        invoiceId: invoiceId,
        amountCents: amountCents,
        paidAt: DateTime.now(),
        method: method,
        receiptNo: 'GP-$invoiceId-${existing + 1}',
      ),
    );
    await Invoice.db.updateRow(
      session,
      invoice.copyWith(status: InvoiceStatus.paid),
    );
    await cancelChase(session, invoiceId);
    return payment;
  }

  /// Judge time-lapse: advance the chase clock [daysAhead] into the future
  /// and send whatever touches are due, for the caller's invoices only.
  /// Same core as the future calls — nothing here is mocked.
  Future<ChaseReport> simulate(Session session, int daysAhead) async {
    final virtualNow = DateTime.now().add(Duration(days: daysAhead));
    final sent = await runChaseStep(
      session,
      now: virtualNow,
      simulated: true,
      ownerId: _owner(session),
    );
    return ChaseReport(
      virtualNow: virtualNow,
      remindersSent: sent.length,
      tiers: sent.map((r) => r.tier).toList(),
    );
  }
}
