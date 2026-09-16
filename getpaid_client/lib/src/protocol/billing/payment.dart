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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class Payment
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Payment._({
    this.id,
    required this.invoiceId,
    required this.amountCents,
    required this.paidAt,
    this.method,
    required this.receiptNo,
  });

  factory Payment({
    int? id,
    required int invoiceId,
    required int amountCents,
    required DateTime paidAt,
    String? method,
    required String receiptNo,
  }) = _PaymentImpl;

  factory Payment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Payment(
      id: jsonSerialization['id'] as int?,
      invoiceId: jsonSerialization['invoiceId'] as int,
      amountCents: jsonSerialization['amountCents'] as int,
      paidAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      method: jsonSerialization['method'] as String?,
      receiptNo: jsonSerialization['receiptNo'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int invoiceId;

  int amountCents;

  DateTime paidAt;

  String? method;

  /// Receipt reference, e.g. GP-7-3.
  String receiptNo;

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Payment copyWith({
    int? id,
    int? invoiceId,
    int? amountCents,
    DateTime? paidAt,
    String? method,
    String? receiptNo,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      'invoiceId': invoiceId,
      'amountCents': amountCents,
      'paidAt': paidAt.toJson(),
      if (method != null) 'method': method,
      'receiptNo': receiptNo,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Payment',
      if (id != null) 'id': id,
      'invoiceId': invoiceId,
      'amountCents': amountCents,
      'paidAt': paidAt.toJson(),
      if (method != null) 'method': method,
      'receiptNo': receiptNo,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentImpl extends Payment {
  _PaymentImpl({
    int? id,
    required int invoiceId,
    required int amountCents,
    required DateTime paidAt,
    String? method,
    required String receiptNo,
  }) : super._(
         id: id,
         invoiceId: invoiceId,
         amountCents: amountCents,
         paidAt: paidAt,
         method: method,
         receiptNo: receiptNo,
       );

  /// Returns a shallow copy of this [Payment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Payment copyWith({
    Object? id = _Undefined,
    int? invoiceId,
    int? amountCents,
    DateTime? paidAt,
    Object? method = _Undefined,
    String? receiptNo,
  }) {
    return Payment(
      id: id is int? ? id : this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      amountCents: amountCents ?? this.amountCents,
      paidAt: paidAt ?? this.paidAt,
      method: method is String? ? method : this.method,
      receiptNo: receiptNo ?? this.receiptNo,
    );
  }
}
