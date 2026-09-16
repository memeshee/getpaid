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

abstract class InvoiceItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InvoiceItem._({
    this.id,
    required this.invoiceId,
    required this.description,
    required this.quantity,
    required this.unitPriceCents,
  });

  factory InvoiceItem({
    int? id,
    required int invoiceId,
    required String description,
    required int quantity,
    required int unitPriceCents,
  }) = _InvoiceItemImpl;

  factory InvoiceItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvoiceItem(
      id: jsonSerialization['id'] as int?,
      invoiceId: jsonSerialization['invoiceId'] as int,
      description: jsonSerialization['description'] as String,
      quantity: jsonSerialization['quantity'] as int,
      unitPriceCents: jsonSerialization['unitPriceCents'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int invoiceId;

  String description;

  int quantity;

  int unitPriceCents;

  /// Returns a shallow copy of this [InvoiceItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InvoiceItem copyWith({
    int? id,
    int? invoiceId,
    String? description,
    int? quantity,
    int? unitPriceCents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvoiceItem',
      if (id != null) 'id': id,
      'invoiceId': invoiceId,
      'description': description,
      'quantity': quantity,
      'unitPriceCents': unitPriceCents,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvoiceItem',
      if (id != null) 'id': id,
      'invoiceId': invoiceId,
      'description': description,
      'quantity': quantity,
      'unitPriceCents': unitPriceCents,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvoiceItemImpl extends InvoiceItem {
  _InvoiceItemImpl({
    int? id,
    required int invoiceId,
    required String description,
    required int quantity,
    required int unitPriceCents,
  }) : super._(
         id: id,
         invoiceId: invoiceId,
         description: description,
         quantity: quantity,
         unitPriceCents: unitPriceCents,
       );

  /// Returns a shallow copy of this [InvoiceItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InvoiceItem copyWith({
    Object? id = _Undefined,
    int? invoiceId,
    String? description,
    int? quantity,
    int? unitPriceCents,
  }) {
    return InvoiceItem(
      id: id is int? ? id : this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPriceCents: unitPriceCents ?? this.unitPriceCents,
    );
  }
}
