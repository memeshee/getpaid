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

/// Payload for a scheduled chase check (null invoiceId = sweep all).
abstract class ChasePayload
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ChasePayload._({this.invoiceId});

  factory ChasePayload({int? invoiceId}) = _ChasePayloadImpl;

  factory ChasePayload.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChasePayload(invoiceId: jsonSerialization['invoiceId'] as int?);
  }

  int? invoiceId;

  /// Returns a shallow copy of this [ChasePayload]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChasePayload copyWith({int? invoiceId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChasePayload',
      if (invoiceId != null) 'invoiceId': invoiceId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChasePayload',
      if (invoiceId != null) 'invoiceId': invoiceId,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChasePayloadImpl extends ChasePayload {
  _ChasePayloadImpl({int? invoiceId}) : super._(invoiceId: invoiceId);

  /// Returns a shallow copy of this [ChasePayload]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ChasePayload copyWith({Object? invoiceId = _Undefined}) {
    return ChasePayload(
      invoiceId: invoiceId is int? ? invoiceId : this.invoiceId,
    );
  }
}
