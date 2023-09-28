import 'package:json_annotation/json_annotation.dart';

part 'usermodel.g.dart';

@JsonSerializable()
class Usermodel {
  Usermodel();

  late String username;
  late String name;
  late String password;
  late String img;
  late String email;
  late String phone;
  late String facebook;
  late String ig;
  
  factory Usermodel.fromJson(Map<String,dynamic> json) => _$UsermodelFromJson(json);
  Map<String, dynamic> toJson() => _$UsermodelToJson(this);
}
