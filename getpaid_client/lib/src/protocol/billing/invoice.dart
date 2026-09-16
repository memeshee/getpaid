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
import '../billing/invoicestatus.dart' as _izwhv7og;

abstract class Invoice
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Invoice._({
    this.id,
    required this.ownerId,
    required this.number,
    required this.customerId,
    required this.amountCents,
    required this.currency,
    this.notes,
    required this.status,
    required this.issueDate,
    required this.dueDate,
    this.sentAt,
    required this.createdAt,
  });

  factory Invoice({
    int? id,
    required String ownerId,
    required String number,
    required int customerId,
    required int amountCents,
    required String currency,
    String? notes,
    required _izwhv7og.InvoiceStatus status,
    required DateTime issueDate,
    required DateTime dueDate,
    DateTime? sentAt,
    required DateTime createdAt,
  }) = _InvoiceImpl;

  factory Invoice.fromJson(Map<String, dynamic> jsonSerialization) {
    return Invoice(
      id: jsonSerialization['id'] as int?,
      ownerId: jsonSerialization['ownerId'] as String,
      number: jsonSerialization['number'] as String,
      customerId: jsonSerialization['customerId'] as int,
      amountCents: jsonSerialization['amountCents'] as int,
      currency: jsonSerialization['currency'] as String,
      notes: jsonSerialization['notes'] as String?,
      status: _izwhv7og.InvoiceStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      issueDate: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['issueDate'],
      ),
      dueDate: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['dueDate'],
      ),
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Owner's auth user id — every query is scoped to this.
  String ownerId;

  /// Human invoice number, e.g. INV-0007.
  String number;

  int customerId;

  /// Total in minor units (cents).
  int amountCents;

  String currency;

  /// Free-text notes / work description.
  String? notes;

  _izwhv7og.InvoiceStatus status;

  DateTime issueDate;

  DateTime dueDate;

  /// Set when the invoice is sent (chase clock starts here).
  DateTime? sentAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [Invoice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Invoice copyWith({
    int? id,
    String? ownerId,
    String? number,
    int? customerId,
    int? amountCents,
    String? currency,
    String? notes,
    _izwhv7og.InvoiceStatus? status,
    DateTime? issueDate,
    DateTime? dueDate,
    DateTime? sentAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Invoice',
      if (id != null) 'id': id,
      'ownerId': ownerId,
      'number': number,
      'customerId': customerId,
      'amountCents': amountCents,
      'currency': currency,
      if (notes != null) 'notes': notes,
      'status': status.toJson(),
      'issueDate': issueDate.toJson(),
      'dueDate': dueDate.toJson(),
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Invoice',
      if (id != null) 'id': id,
      'ownerId': ownerId,
      'number': number,
      'customerId': customerId,
      'amountCents': amountCents,
      'currency': currency,
      if (notes != null) 'notes': notes,
      'status': status.toJson(),
      'issueDate': issueDate.toJson(),
      'dueDate': dueDate.toJson(),
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvoiceImpl extends Invoice {
  _InvoiceImpl({
    int? id,
    required String ownerId,
    required String number,
    required int customerId,
    required int amountCents,
    required String currency,
    String? notes,
    required _izwhv7og.InvoiceStatus status,
    required DateTime issueDate,
    required DateTime dueDate,
    DateTime? sentAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         number: number,
         customerId: customerId,
         amountCents: amountCents,
         currency: currency,
         notes: notes,
         status: status,
         issueDate: issueDate,
         dueDate: dueDate,
         sentAt: sentAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Invoice]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Invoice copyWith({
    Object? id = _Undefined,
    String? ownerId,
    String? number,
    int? customerId,
    int? amountCents,
    String? currency,
    Object? notes = _Undefined,
    _izwhv7og.InvoiceStatus? status,
    DateTime? issueDate,
    DateTime? dueDate,
    Object? sentAt = _Undefined,
    DateTime? createdAt,
  }) {
    return Invoice(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      number: number ?? this.number,
      customerId: customerId ?? this.customerId,
      amountCents: amountCents ?? this.amountCents,
      currency: currency ?? this.currency,
      notes: notes is String? ? notes : this.notes,
      status: status ?? this.status,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
