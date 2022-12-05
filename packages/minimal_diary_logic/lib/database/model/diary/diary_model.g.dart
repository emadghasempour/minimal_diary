// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_model.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class DiaryData extends DataClass implements Insertable<DiaryData> {
  final int id;
  final int userId;
  final String? title;
  final String? diary;
  final DateTime date;
  final Relation? relation;
  DiaryData(
      {required this.id,
      required this.userId,
      this.title,
      this.diary,
      required this.date,
      this.relation});
  factory DiaryData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DiaryData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      userId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
      diary: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}diary']),
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      relation: $DiaryTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}relation'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String?>(title);
    }
    if (!nullToAbsent || diary != null) {
      map['diary'] = Variable<String?>(diary);
    }
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || relation != null) {
      final converter = $DiaryTable.$converter0;
      map['relation'] = Variable<String?>(converter.mapToSql(relation));
    }
    return map;
  }

  DiaryCompanion toCompanion(bool nullToAbsent) {
    return DiaryCompanion(
      id: Value(id),
      userId: Value(userId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      diary:
          diary == null && nullToAbsent ? const Value.absent() : Value(diary),
      date: Value(date),
      relation: relation == null && nullToAbsent
          ? const Value.absent()
          : Value(relation),
    );
  }

  factory DiaryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiaryData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      title: serializer.fromJson<String?>(json['title']),
      diary: serializer.fromJson<String?>(json['diary']),
      date: serializer.fromJson<DateTime>(json['date']),
      relation: serializer.fromJson<Relation?>(json['relation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'title': serializer.toJson<String?>(title),
      'diary': serializer.toJson<String?>(diary),
      'date': serializer.toJson<DateTime>(date),
      'relation': serializer.toJson<Relation?>(relation),
    };
  }

  DiaryData copyWith(
          {int? id,
          int? userId,
          String? title,
          String? diary,
          DateTime? date,
          Relation? relation}) =>
      DiaryData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        diary: diary ?? this.diary,
        date: date ?? this.date,
        relation: relation ?? this.relation,
      );
  @override
  String toString() {
    return (StringBuffer('DiaryData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('diary: $diary, ')
          ..write('date: $date, ')
          ..write('relation: $relation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, title, diary, date, relation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiaryData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.diary == this.diary &&
          other.date == this.date &&
          other.relation == this.relation);
}

class DiaryCompanion extends UpdateCompanion<DiaryData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String?> title;
  final Value<String?> diary;
  final Value<DateTime> date;
  final Value<Relation?> relation;
  const DiaryCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.diary = const Value.absent(),
    this.date = const Value.absent(),
    this.relation = const Value.absent(),
  });
  DiaryCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    this.title = const Value.absent(),
    this.diary = const Value.absent(),
    required DateTime date,
    this.relation = const Value.absent(),
  })  : userId = Value(userId),
        date = Value(date);
  static Insertable<DiaryData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String?>? title,
    Expression<String?>? diary,
    Expression<DateTime>? date,
    Expression<Relation?>? relation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (diary != null) 'diary': diary,
      if (date != null) 'date': date,
      if (relation != null) 'relation': relation,
    });
  }

  DiaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String?>? title,
      Value<String?>? diary,
      Value<DateTime>? date,
      Value<Relation?>? relation}) {
    return DiaryCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      diary: diary ?? this.diary,
      date: date ?? this.date,
      relation: relation ?? this.relation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String?>(title.value);
    }
    if (diary.present) {
      map['diary'] = Variable<String?>(diary.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (relation.present) {
      final converter = $DiaryTable.$converter0;
      map['relation'] = Variable<String?>(converter.mapToSql(relation.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiaryCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('diary: $diary, ')
          ..write('date: $date, ')
          ..write('relation: $relation')
          ..write(')'))
        .toString();
  }
}

class $DiaryTable extends Diary with TableInfo<$DiaryTable, DiaryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiaryTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int?> userId = GeneratedColumn<int?>(
      'user_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _diaryMeta = const VerificationMeta('diary');
  @override
  late final GeneratedColumn<String?> diary = GeneratedColumn<String?>(
      'diary', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _relationMeta = const VerificationMeta('relation');
  @override
  late final GeneratedColumnWithTypeConverter<Relation, String?> relation =
      GeneratedColumn<String?>('relation', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<Relation>($DiaryTable.$converter0);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, title, diary, date, relation];
  @override
  String get aliasedName => _alias ?? 'diary';
  @override
  String get actualTableName => 'diary';
  @override
  VerificationContext validateIntegrity(Insertable<DiaryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('diary')) {
      context.handle(
          _diaryMeta, diary.isAcceptableOrUnknown(data['diary']!, _diaryMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    context.handle(_relationMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiaryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DiaryData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DiaryTable createAlias(String alias) {
    return $DiaryTable(attachedDatabase, alias);
  }

  static TypeConverter<Relation, String> $converter0 =
      const RelationConverter();
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $DiaryTable diary = $DiaryTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [diary];
}
