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
import '../billing/remindertier.dart' as _ip4xzb4r;

abstract class ChaseReport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChaseReport._({
    required this.virtualNow,
    required this.remindersSent,
    required this.tiers,
  });

  factory ChaseReport({
    required DateTime virtualNow,
    required int remindersSent,
    required List<_ip4xzb4r.ReminderTier> tiers,
  }) = _ChaseReportImpl;

  factory ChaseReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChaseReport(
      virtualNow: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['virtualNow'],
      ),
      remindersSent: jsonSerialization['remindersSent'] as int,
      tiers: _i1k0i8vo.Protocol().deserialize<List<_ip4xzb4r.ReminderTier>>(
        jsonSerialization['tiers'],
      ),
    );
  }

  DateTime virtualNow;

  int remindersSent;

  List<_ip4xzb4r.ReminderTier> tiers;

  /// Returns a shallow copy of this [ChaseReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChaseReport copyWith({
    DateTime? virtualNow,
    int? remindersSent,
    List<_ip4xzb4r.ReminderTier>? tiers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChaseReport',
      'virtualNow': virtualNow.toJson(),
      'remindersSent': remindersSent,
      'tiers': tiers.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChaseReport',
      'virtualNow': virtualNow.toJson(),
      'remindersSent': remindersSent,
      'tiers': tiers.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ChaseReportImpl extends ChaseReport {
  _ChaseReportImpl({
    required DateTime virtualNow,
    required int remindersSent,
    required List<_ip4xzb4r.ReminderTier> tiers,
  }) : super._(
         virtualNow: virtualNow,
         remindersSent: remindersSent,
         tiers: tiers,
       );

  /// Returns a shallow copy of this [ChaseReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChaseReport copyWith({
    DateTime? virtualNow,
    int? remindersSent,
    List<_ip4xzb4r.ReminderTier>? tiers,
  }) {
    return ChaseReport(
      virtualNow: virtualNow ?? this.virtualNow,
      remindersSent: remindersSent ?? this.remindersSent,
      tiers: tiers ?? this.tiers.map((e0) => e0).toList(),
    );
  }
}
