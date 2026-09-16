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
import 'package:serverpod/serverpod.dart' as _is;

abstract class InvoiceItemInput
    implements _is.SerializableModel, _is.ProtocolSerialization {
  InvoiceItemInput._({
    required this.description,
    required this.quantity,
    required this.unitPriceCents,
  });

  factory InvoiceItemInput({
    required String description,
    required int quantity,
    required int unitPriceCents,
  }) = _InvoiceItemInputImpl;

  factory InvoiceItemInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvoiceItemInput(
      description: jsonSerialization['description'] as String,
      quantity: jsonSerialization['quantity'] as int,
      unitPriceCents: jsonSerialization['unitPriceCents'] as int,
    );
  }

  String description;

  int quantity;

  int unitPriceCents;

  /// Returns a shallow copy of this [InvoiceItemInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InvoiceItemInput copyWith({
    String? description,
    int? quantity,
    int? unitPriceCents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvoiceItemInput',
      'description': description,
      'quantity': quantity,
      'unitPriceCents': unitPriceCents,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvoiceItemInput',
      'description': description,
      'quantity': quantity,
      'unitPriceCents': unitPriceCents,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _InvoiceItemInputImpl extends InvoiceItemInput {
  _InvoiceItemInputImpl({
    required String description,
    required int quantity,
    required int unitPriceCents,
  }) : super._(
         description: description,
         quantity: quantity,
         unitPriceCents: unitPriceCents,
       );

  /// Returns a shallow copy of this [InvoiceItemInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InvoiceItemInput copyWith({
    String? description,
    int? quantity,
    int? unitPriceCents,
  }) {
    return InvoiceItemInput(
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPriceCents: unitPriceCents ?? this.unitPriceCents,
    );
  }
}
