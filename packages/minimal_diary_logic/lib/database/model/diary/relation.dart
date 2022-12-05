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
    return Relation.fromJson(json.decode(fromDb!) as Map<String,dynamic>);
  }
  
  @override
  String? mapToSql(Relation? value) {
    return json.encode(value!.toJson());
  }
}