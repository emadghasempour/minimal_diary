import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;
part 'relation.g.dart';

@j.JsonSerializable()
class Relation {
  final List<int> relations;

  Relation(this.relations);
  factory Relation.fromJson(Map<String, dynamic> json) =>
      _$RelationFromJson(json);

  Map<String, dynamic> toJson() => _$RelationToJson(this);
}

class RelationConverter extends TypeConverter<Relation, String> {
  const RelationConverter();

  @override
  Relation? mapToDart(String? fromDb) {
    if (fromDb != null) {
      return Relation.fromJson(json.decode(fromDb) as Map<String, dynamic>);
    }
    return null;
  }

  @override
  String? mapToSql(Relation? value) {
    if (value != null) {
      return json.encode(value!.toJson());
    }
    return null;
  }
}
