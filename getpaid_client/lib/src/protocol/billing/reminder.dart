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
import '../billing/reminderstatus.dart' as _i6gkku4a;
import '../billing/remindertier.dart' as _ip4xzb4r;

abstract class Reminder
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Reminder._({
    this.id,
    required this.invoiceId,
    required this.tier,
    required this.status,
    required this.dueAt,
    this.sentAt,
    this.subject,
    this.body,
    required this.simulated,
  });

  factory Reminder({
    int? id,
    required int invoiceId,
    required _ip4xzb4r.ReminderTier tier,
    required _i6gkku4a.ReminderStatus status,
    required DateTime dueAt,
    DateTime? sentAt,
    String? subject,
    String? body,
    required bool simulated,
  }) = _ReminderImpl;

  factory Reminder.fromJson(Map<String, dynamic> jsonSerialization) {
    return Reminder(
      id: jsonSerialization['id'] as int?,
      invoiceId: jsonSerialization['invoiceId'] as int,
      tier: _ip4xzb4r.ReminderTier.fromJson(
        (jsonSerialization['tier'] as String),
      ),
      status: _i6gkku4a.ReminderStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      dueAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      subject: jsonSerialization['subject'] as String?,
      body: jsonSerialization['body'] as String?,
      simulated: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['simulated'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int invoiceId;

  _ip4xzb4r.ReminderTier tier;

  _i6gkku4a.ReminderStatus status;

  /// When this touch becomes due.
  DateTime dueAt;

  /// When it was actually sent (null until sent).
  DateTime? sentAt;

  /// Subject line used.
  String? subject;

  /// Body used.
  String? body;

  /// True when produced by simulate() (judge time-lapse), not real time.
  bool simulated;

  /// Returns a shallow copy of this [Reminder]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Reminder copyWith({
    int? id,
    int? invoiceId,
    _ip4xzb4r.ReminderTier? tier,
    _i6gkku4a.ReminderStatus? status,
    DateTime? dueAt,
    DateTime? sentAt,
    String? subject,
    String? body,
    bool? simulated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Reminder',
      if (id != null) 'id': id,
      'invoiceId': invoiceId,
      'tier': tier.toJson(),
      'status': status.toJson(),
      'dueAt': dueAt.toJson(),
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
      'simulated': simulated,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Reminder',
      if (id != null) 'id': id,
      'invoiceId': invoiceId,
      'tier': tier.toJson(),
      'status': status.toJson(),
      'dueAt': dueAt.toJson(),
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
      'simulated': simulated,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReminderImpl extends Reminder {
  _ReminderImpl({
    int? id,
    required int invoiceId,
    required _ip4xzb4r.ReminderTier tier,
    required _i6gkku4a.ReminderStatus status,
    required DateTime dueAt,
    DateTime? sentAt,
    String? subject,
    String? body,
    required bool simulated,
  }) : super._(
         id: id,
         invoiceId: invoiceId,
         tier: tier,
         status: status,
         dueAt: dueAt,
         sentAt: sentAt,
         subject: subject,
         body: body,
         simulated: simulated,
       );

  /// Returns a shallow copy of this [Reminder]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Reminder copyWith({
    Object? id = _Undefined,
    int? invoiceId,
    _ip4xzb4r.ReminderTier? tier,
    _i6gkku4a.ReminderStatus? status,
    DateTime? dueAt,
    Object? sentAt = _Undefined,
    Object? subject = _Undefined,
    Object? body = _Undefined,
    bool? simulated,
  }) {
    return Reminder(
      id: id is int? ? id : this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      tier: tier ?? this.tier,
      status: status ?? this.status,
      dueAt: dueAt ?? this.dueAt,
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
      subject: subject is String? ? subject : this.subject,
      body: body is String? ? body : this.body,
      simulated: simulated ?? this.simulated,
    );
  }
}
