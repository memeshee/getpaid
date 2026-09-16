/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:getpaid_client/src/protocol/billing/customer.dart' as _idhwohgz;
import 'package:getpaid_client/src/protocol/billing/invoice.dart' as _idcg60kg;
import 'package:getpaid_client/src/protocol/billing/invoice_item_input.dart'
    as _i1bate66;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'billing/chase_payload.dart' as _ia1k726e;
import 'billing/chase_report.dart' as _i2w3w3bk;
import 'billing/customer.dart' as _ikssxryt;
import 'billing/invoice.dart' as _iqnokql9;
import 'billing/invoice_item.dart' as _iu9nqt2o;
import 'billing/invoice_item_input.dart' as _ik8gxqn9;
import 'billing/invoice_thread.dart' as _ik4gaqqo;
import 'billing/invoicestatus.dart' as _iun91wyj;
import 'billing/payment.dart' as _ifq0dbbu;
import 'billing/reminder.dart' as _iuqb54o7;
import 'billing/reminderstatus.dart' as _iuzd6bk9;
import 'billing/remindertier.dart' as _i8ud335r;
import 'greetings/greeting.dart' as _izw8z7ou;
export 'billing/chase_payload.dart';
export 'billing/chase_report.dart';
export 'billing/customer.dart';
export 'billing/invoice.dart';
export 'billing/invoice_item.dart';
export 'billing/invoice_item_input.dart';
export 'billing/invoice_thread.dart';
export 'billing/invoicestatus.dart';
export 'billing/payment.dart';
export 'billing/reminder.dart';
export 'billing/reminderstatus.dart';
export 'billing/remindertier.dart';
export 'greetings/greeting.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ia1k726e.ChasePayload) {
      return _ia1k726e.ChasePayload.fromJson(data) as T;
    }
    if (t == _i2w3w3bk.ChaseReport) {
      return _i2w3w3bk.ChaseReport.fromJson(data) as T;
    }
    if (t == _ikssxryt.Customer) {
      return _ikssxryt.Customer.fromJson(data) as T;
    }
    if (t == _iqnokql9.Invoice) {
      return _iqnokql9.Invoice.fromJson(data) as T;
    }
    if (t == _iu9nqt2o.InvoiceItem) {
      return _iu9nqt2o.InvoiceItem.fromJson(data) as T;
    }
    if (t == _ik8gxqn9.InvoiceItemInput) {
      return _ik8gxqn9.InvoiceItemInput.fromJson(data) as T;
    }
    if (t == _ik4gaqqo.InvoiceThread) {
      return _ik4gaqqo.InvoiceThread.fromJson(data) as T;
    }
    if (t == _iun91wyj.InvoiceStatus) {
      return _iun91wyj.InvoiceStatus.fromJson(data) as T;
    }
    if (t == _ifq0dbbu.Payment) {
      return _ifq0dbbu.Payment.fromJson(data) as T;
    }
    if (t == _iuqb54o7.Reminder) {
      return _iuqb54o7.Reminder.fromJson(data) as T;
    }
    if (t == _iuzd6bk9.ReminderStatus) {
      return _iuzd6bk9.ReminderStatus.fromJson(data) as T;
    }
    if (t == _i8ud335r.ReminderTier) {
      return _i8ud335r.ReminderTier.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _isc.getType<_ia1k726e.ChasePayload?>()) {
      return (data != null ? _ia1k726e.ChasePayload.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i2w3w3bk.ChaseReport?>()) {
      return (data != null ? _i2w3w3bk.ChaseReport.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ikssxryt.Customer?>()) {
      return (data != null ? _ikssxryt.Customer.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqnokql9.Invoice?>()) {
      return (data != null ? _iqnokql9.Invoice.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iu9nqt2o.InvoiceItem?>()) {
      return (data != null ? _iu9nqt2o.InvoiceItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ik8gxqn9.InvoiceItemInput?>()) {
      return (data != null ? _ik8gxqn9.InvoiceItemInput.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ik4gaqqo.InvoiceThread?>()) {
      return (data != null ? _ik4gaqqo.InvoiceThread.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iun91wyj.InvoiceStatus?>()) {
      return (data != null ? _iun91wyj.InvoiceStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ifq0dbbu.Payment?>()) {
      return (data != null ? _ifq0dbbu.Payment.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iuqb54o7.Reminder?>()) {
      return (data != null ? _iuqb54o7.Reminder.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iuzd6bk9.ReminderStatus?>()) {
      return (data != null ? _iuzd6bk9.ReminderStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i8ud335r.ReminderTier?>()) {
      return (data != null ? _i8ud335r.ReminderTier.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == List<_i8ud335r.ReminderTier>) {
      return (data as List)
              .map((e) => deserialize<_i8ud335r.ReminderTier>(e))
              .toList()
          as T;
    }
    if (t == List<_iu9nqt2o.InvoiceItem>) {
      return (data as List)
              .map((e) => deserialize<_iu9nqt2o.InvoiceItem>(e))
              .toList()
          as T;
    }
    if (t == List<_iuqb54o7.Reminder>) {
      return (data as List)
              .map((e) => deserialize<_iuqb54o7.Reminder>(e))
              .toList()
          as T;
    }
    if (t == List<_ifq0dbbu.Payment>) {
      return (data as List)
              .map((e) => deserialize<_ifq0dbbu.Payment>(e))
              .toList()
          as T;
    }
    if (t == List<_idhwohgz.Customer>) {
      return (data as List)
              .map((e) => deserialize<_idhwohgz.Customer>(e))
              .toList()
          as T;
    }
    if (t == List<_idcg60kg.Invoice>) {
      return (data as List)
              .map((e) => deserialize<_idcg60kg.Invoice>(e))
              .toList()
          as T;
    }
    if (t == List<_i1bate66.InvoiceItemInput>) {
      return (data as List)
              .map((e) => deserialize<_i1bate66.InvoiceItemInput>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i1bate66.InvoiceItemInput>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i1bate66.InvoiceItemInput>(e))
                    .toList()
              : null)
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ia1k726e.ChasePayload => 'ChasePayload',
      _i2w3w3bk.ChaseReport => 'ChaseReport',
      _ikssxryt.Customer => 'Customer',
      _iqnokql9.Invoice => 'Invoice',
      _iu9nqt2o.InvoiceItem => 'InvoiceItem',
      _ik8gxqn9.InvoiceItemInput => 'InvoiceItemInput',
      _ik4gaqqo.InvoiceThread => 'InvoiceThread',
      _iun91wyj.InvoiceStatus => 'InvoiceStatus',
      _ifq0dbbu.Payment => 'Payment',
      _iuqb54o7.Reminder => 'Reminder',
      _iuzd6bk9.ReminderStatus => 'ReminderStatus',
      _i8ud335r.ReminderTier => 'ReminderTier',
      _izw8z7ou.Greeting => 'Greeting',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('getpaid.', '');
    }

    switch (data) {
      case _ia1k726e.ChasePayload():
        return 'ChasePayload';
      case _i2w3w3bk.ChaseReport():
        return 'ChaseReport';
      case _ikssxryt.Customer():
        return 'Customer';
      case _iqnokql9.Invoice():
        return 'Invoice';
      case _iu9nqt2o.InvoiceItem():
        return 'InvoiceItem';
      case _ik8gxqn9.InvoiceItemInput():
        return 'InvoiceItemInput';
      case _ik4gaqqo.InvoiceThread():
        return 'InvoiceThread';
      case _iun91wyj.InvoiceStatus():
        return 'InvoiceStatus';
      case _ifq0dbbu.Payment():
        return 'Payment';
      case _iuqb54o7.Reminder():
        return 'Reminder';
      case _iuzd6bk9.ReminderStatus():
        return 'ReminderStatus';
      case _i8ud335r.ReminderTier():
        return 'ReminderTier';
      case _izw8z7ou.Greeting():
        return 'Greeting';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ChasePayload') {
      return deserialize<_ia1k726e.ChasePayload>(data['data']);
    }
    if (dataClassName == 'ChaseReport') {
      return deserialize<_i2w3w3bk.ChaseReport>(data['data']);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_ikssxryt.Customer>(data['data']);
    }
    if (dataClassName == 'Invoice') {
      return deserialize<_iqnokql9.Invoice>(data['data']);
    }
    if (dataClassName == 'InvoiceItem') {
      return deserialize<_iu9nqt2o.InvoiceItem>(data['data']);
    }
    if (dataClassName == 'InvoiceItemInput') {
      return deserialize<_ik8gxqn9.InvoiceItemInput>(data['data']);
    }
    if (dataClassName == 'InvoiceThread') {
      return deserialize<_ik4gaqqo.InvoiceThread>(data['data']);
    }
    if (dataClassName == 'InvoiceStatus') {
      return deserialize<_iun91wyj.InvoiceStatus>(data['data']);
    }
    if (dataClassName == 'Payment') {
      return deserialize<_ifq0dbbu.Payment>(data['data']);
    }
    if (dataClassName == 'Reminder') {
      return deserialize<_iuqb54o7.Reminder>(data['data']);
    }
    if (dataClassName == 'ReminderStatus') {
      return deserialize<_iuzd6bk9.ReminderStatus>(data['data']);
    }
    if (dataClassName == 'ReminderTier') {
      return deserialize<_i8ud335r.ReminderTier>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('getpaid', this);
    _iacc.Protocol().registerHostProtocol('getpaid', this);
  }

  @override
  String getModuleName() => 'getpaid';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
