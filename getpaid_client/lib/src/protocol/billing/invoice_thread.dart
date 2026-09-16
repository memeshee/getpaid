/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:getpaid_client/src/protocol/protocol.dart' as _i1k0i8vo;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../billing/customer.dart' as _i5j7u0j7;
import '../billing/invoice.dart' as _i78desnl;
import '../billing/invoice_item.dart' as _izlwvvwo;
import '../billing/payment.dart' as _i5od23c2;
import '../billing/reminder.dart' as _i0keiged;

abstract class InvoiceThread
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InvoiceThread._({
    required this.invoice,
    this.client,
    required this.items,
    required this.reminders,
    required this.payments,
  });

  factory InvoiceThread({
    required _i78desnl.Invoice invoice,
    _i5j7u0j7.Customer? client,
    required List<_izlwvvwo.InvoiceItem> items,
    required List<_i0keiged.Reminder> reminders,
    required List<_i5od23c2.Payment> payments,
  }) = _InvoiceThreadImpl;

  factory InvoiceThread.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvoiceThread(
      invoice: _i1k0i8vo.Protocol().deserialize<_i78desnl.Invoice>(
        jsonSerialization['invoice'],
      ),
      client: jsonSerialization['client'] == null
          ? null
          : _i1k0i8vo.Protocol().deserialize<_i5j7u0j7.Customer>(
              jsonSerialization['client'],
            ),
      items: _i1k0i8vo.Protocol().deserialize<List<_izlwvvwo.InvoiceItem>>(
        jsonSerialization['items'],
      ),
      reminders: _i1k0i8vo.Protocol().deserialize<List<_i0keiged.Reminder>>(
        jsonSerialization['reminders'],
      ),
      payments: _i1k0i8vo.Protocol().deserialize<List<_i5od23c2.Payment>>(
        jsonSerialization['payments'],
      ),
    );
  }

  _i78desnl.Invoice invoice;

  _i5j7u0j7.Customer? client;

  List<_izlwvvwo.InvoiceItem> items;

  List<_i0keiged.Reminder> reminders;

  List<_i5od23c2.Payment> payments;

  /// Returns a shallow copy of this [InvoiceThread]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InvoiceThread copyWith({
    _i78desnl.Invoice? invoice,
    _i5j7u0j7.Customer? client,
    List<_izlwvvwo.InvoiceItem>? items,
    List<_i0keiged.Reminder>? reminders,
    List<_i5od23c2.Payment>? payments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvoiceThread',
      'invoice': invoice.toJson(),
      if (client != null) 'client': client?.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'reminders': reminders.toJson(valueToJson: (v) => v.toJson()),
      'payments': payments.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvoiceThread',
      'invoice': invoice.toJsonForProtocol(),
      if (client != null) 'client': client?.toJsonForProtocol(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'reminders': reminders.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'payments': payments.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvoiceThreadImpl extends InvoiceThread {
  _InvoiceThreadImpl({
    required _i78desnl.Invoice invoice,
    _i5j7u0j7.Customer? client,
    required List<_izlwvvwo.InvoiceItem> items,
    required List<_i0keiged.Reminder> reminders,
    required List<_i5od23c2.Payment> payments,
  }) : super._(
         invoice: invoice,
         client: client,
         items: items,
         reminders: reminders,
         payments: payments,
       );

  /// Returns a shallow copy of this [InvoiceThread]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InvoiceThread copyWith({
    _i78desnl.Invoice? invoice,
    Object? client = _Undefined,
    List<_izlwvvwo.InvoiceItem>? items,
    List<_i0keiged.Reminder>? reminders,
    List<_i5od23c2.Payment>? payments,
  }) {
    return InvoiceThread(
      invoice: invoice ?? this.invoice.copyWith(),
      client: client is _i5j7u0j7.Customer? ? client : this.client?.copyWith(),
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      reminders:
          reminders ?? this.reminders.map((e0) => e0.copyWith()).toList(),
      payments: payments ?? this.payments.map((e0) => e0.copyWith()).toList(),
    );
  }
}
