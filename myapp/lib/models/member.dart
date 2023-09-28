import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  Member();

  late String username;
  late String name;
  late String img;
  late String phone;
  late String email;
  late String facebook;
  late String ig;
  late String memo;
  late String mood;
  late String lat;
  late String lng;
  late String statusdate;
  
  factory Member.fromJson(Map<String,dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
