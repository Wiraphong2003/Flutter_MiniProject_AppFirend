import 'package:json_annotation/json_annotation.dart';

import "group.dart";

part 'groups.g.dart';

@JsonSerializable()
class Groups {
  Groups();

  late List<Group> groups;

  factory Groups.fromJson(Map<String, dynamic> json) => _$GroupsFromJson(json);

  get name => null;
  Map<String, dynamic> toJson() => _$GroupsToJson(this);
}
