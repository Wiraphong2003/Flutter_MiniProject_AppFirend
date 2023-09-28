import 'package:json_annotation/json_annotation.dart';
import "member.dart";
part 'members.g.dart';

@JsonSerializable()
class Members {
  Members();

  late List<Member> members;
  
  factory Members.fromJson(Map<String,dynamic> json) => _$MembersFromJson(json);
  Map<String, dynamic> toJson() => _$MembersToJson(this);
}
