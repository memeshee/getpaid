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
import '../billing/invoicestatus.dart' as _izwhv7og;

abstract class Invoice
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      issueDate: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['issueDate'],
      ),
      dueDate: _is.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = InvoiceTable();

  static const db = InvoiceRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Invoice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static InvoiceInclude include() {
    return InvoiceInclude._();
  }

  static InvoiceIncludeList includeList({
    _is.WhereExpressionBuilder<InvoiceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvoiceTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTable>? orderByList,
    InvoiceInclude? include,
  }) {
    return InvoiceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Invoice.t),
      orderByList: orderByList?.call(Invoice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class InvoiceUpdateTable extends _is.UpdateTable<InvoiceTable> {
  InvoiceUpdateTable(super.table);

  _is.ColumnValue<String, String> ownerId(String value) => _is.ColumnValue(
    table.ownerId,
    value,
  );

  _is.ColumnValue<String, String> number(String value) => _is.ColumnValue(
    table.number,
    value,
  );

  _is.ColumnValue<int, int> customerId(int value) => _is.ColumnValue(
    table.customerId,
    value,
  );

  _is.ColumnValue<int, int> amountCents(int value) => _is.ColumnValue(
    table.amountCents,
    value,
  );

  _is.ColumnValue<String, String> currency(String value) => _is.ColumnValue(
    table.currency,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );

  _is.ColumnValue<_izwhv7og.InvoiceStatus, _izwhv7og.InvoiceStatus> status(
    _izwhv7og.InvoiceStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> issueDate(DateTime value) =>
      _is.ColumnValue(
        table.issueDate,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> dueDate(DateTime value) =>
      _is.ColumnValue(
        table.dueDate,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> sentAt(DateTime? value) =>
      _is.ColumnValue(
        table.sentAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class InvoiceTable extends _is.Table<int?> {
  InvoiceTable({super.tableRelation}) : super(tableName: 'invoice') {
    updateTable = InvoiceUpdateTable(this);
    ownerId = _is.ColumnString(
      'ownerId',
      this,
    );
    number = _is.ColumnString(
      'number',
      this,
    );
    customerId = _is.ColumnInt(
      'customerId',
      this,
    );
    amountCents = _is.ColumnInt(
      'amountCents',
      this,
    );
    currency = _is.ColumnString(
      'currency',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    issueDate = _is.ColumnDateTime(
      'issueDate',
      this,
    );
    dueDate = _is.ColumnDateTime(
      'dueDate',
      this,
    );
    sentAt = _is.ColumnDateTime(
      'sentAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final InvoiceUpdateTable updateTable;

  /// Owner's auth user id — every query is scoped to this.
  late final _is.ColumnString ownerId;

  /// Human invoice number, e.g. INV-0007.
  late final _is.ColumnString number;

  late final _is.ColumnInt customerId;

  /// Total in minor units (cents).
  late final _is.ColumnInt amountCents;

  late final _is.ColumnString currency;

  /// Free-text notes / work description.
  late final _is.ColumnString notes;

  late final _is.ColumnEnum<_izwhv7og.InvoiceStatus> status;

  late final _is.ColumnDateTime issueDate;

  late final _is.ColumnDateTime dueDate;

  /// Set when the invoice is sent (chase clock starts here).
  late final _is.ColumnDateTime sentAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    number,
    customerId,
    amountCents,
    currency,
    notes,
    status,
    issueDate,
    dueDate,
    sentAt,
    createdAt,
  ];
}

class InvoiceInclude extends _is.IncludeObject {
  InvoiceInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Invoice.t;
}

class InvoiceIncludeList extends _is.IncludeList {
  InvoiceIncludeList._({
    _is.WhereExpressionBuilder<InvoiceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Invoice.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Invoice.t;
}

class InvoiceRepository {
  const InvoiceRepository._();

  /// Returns a list of [Invoice]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Invoice>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvoiceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvoiceTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Invoice>(
      where: where?.call(Invoice.t),
      orderBy: orderBy?.call(Invoice.t),
      orderByList: orderByList?.call(Invoice.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Invoice] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Invoice?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvoiceTable>? where,
    int? offset,
    _is.OrderByBuilder<InvoiceTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Invoice>(
      where: where?.call(Invoice.t),
      orderBy: orderBy?.call(Invoice.t),
      orderByList: orderByList?.call(Invoice.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Invoice] by its [id] or null if no such row exists.
  Future<Invoice?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Invoice>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Invoice]s in the list and returns the inserted rows.
  ///
  /// The returned [Invoice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invoice>> insert(
    _is.DatabaseSession session,
    List<Invoice> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Invoice>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Invoice] and returns the inserted row.
  ///
  /// The returned [Invoice] will have its `id` field set.
  Future<Invoice> insertRow(
    _is.DatabaseSession session,
    Invoice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Invoice>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Invoice]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Invoice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invoice>> upsert(
    _is.DatabaseSession session,
    List<Invoice> rows, {
    required _is.ColumnSelections<InvoiceTable> conflictColumns,
    _is.ColumnSelections<InvoiceTable>? updateColumns,
    _is.WhereExpressionBuilder<InvoiceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Invoice>(
      rows,
      conflictColumns: conflictColumns(Invoice.t),
      updateColumns: updateColumns?.call(Invoice.t),
      updateWhere: updateWhere?.call(Invoice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Invoice] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Invoice] will have its `id` field set.
  Future<Invoice?> upsertRow(
    _is.DatabaseSession session,
    Invoice row, {
    required _is.ColumnSelections<InvoiceTable> conflictColumns,
    _is.ColumnSelections<InvoiceTable>? updateColumns,
    _is.WhereExpressionBuilder<InvoiceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Invoice>(
      row,
      conflictColumns: conflictColumns(Invoice.t),
      updateColumns: updateColumns?.call(Invoice.t),
      updateWhere: updateWhere?.call(Invoice.t),
      transaction: transaction,
    );
  }

  /// Updates all [Invoice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invoice>> update(
    _is.DatabaseSession session,
    List<Invoice> rows, {
    _is.ColumnSelections<InvoiceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Invoice>(
      rows,
      columns: columns?.call(Invoice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Invoice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Invoice> updateRow(
    _is.DatabaseSession session,
    Invoice row, {
    _is.ColumnSelections<InvoiceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Invoice>(
      row,
      columns: columns?.call(Invoice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Invoice] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Invoice?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InvoiceUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Invoice>(
      id,
      columnValues: columnValues(Invoice.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Invoice]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invoice>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InvoiceUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<InvoiceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvoiceTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Invoice>(
      columnValues: columnValues(Invoice.t.updateTable),
      where: where(Invoice.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Invoice.t),
      orderByList: orderByList?.call(Invoice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Invoice]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invoice>> delete(
    _is.DatabaseSession session,
    List<Invoice> rows, {
    _is.OrderByBuilder<InvoiceTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Invoice>(
      rows,
      orderBy: orderBy?.call(Invoice.t),
      orderByList: orderByList?.call(Invoice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Invoice].
  Future<Invoice> deleteRow(
    _is.DatabaseSession session,
    Invoice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Invoice>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invoice>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InvoiceTable> where,
    _is.OrderByBuilder<InvoiceTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Invoice>(
      where: where(Invoice.t),
      orderBy: orderBy?.call(Invoice.t),
      orderByList: orderByList?.call(Invoice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvoiceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Invoice>(
      where: where?.call(Invoice.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Invoice] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InvoiceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Invoice>(
      where: where(Invoice.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
