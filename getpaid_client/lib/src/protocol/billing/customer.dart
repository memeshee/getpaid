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

abstract class Customer
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Customer._({
    this.id,
    required this.ownerId,
    required this.name,
    required this.email,
    this.company,
    required this.createdAt,
  });

  factory Customer({
    int? id,
    required String ownerId,
    required String name,
    required String email,
    String? company,
    required DateTime createdAt,
  }) = _CustomerImpl;

  factory Customer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Customer(
      id: jsonSerialization['id'] as int?,
      ownerId: jsonSerialization['ownerId'] as String,
      name: jsonSerialization['name'] as String,
      email: jsonSerialization['email'] as String,
      company: jsonSerialization['company'] as String?,
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

  /// Display name (person or company).
  String name;

  /// Billing email — reminders go here.
  String email;

  /// Optional company name.
  String? company;

  DateTime createdAt;

  /// Returns a shallow copy of this [Customer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Customer copyWith({
    int? id,
    String? ownerId,
    String? name,
    String? email,
    String? company,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Customer',
      if (id != null) 'id': id,
      'ownerId': ownerId,
      'name': name,
      'email': email,
      if (company != null) 'company': company,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Customer',
      if (id != null) 'id': id,
      'ownerId': ownerId,
      'name': name,
      'email': email,
      if (company != null) 'company': company,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerImpl extends Customer {
  _CustomerImpl({
    int? id,
    required String ownerId,
    required String name,
    required String email,
    String? company,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         name: name,
         email: email,
         company: company,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Customer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Customer copyWith({
    Object? id = _Undefined,
    String? ownerId,
    String? name,
    String? email,
    Object? company = _Undefined,
    DateTime? createdAt,
  }) {
    return Customer(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      email: email ?? this.email,
      company: company is String? ? company : this.company,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
