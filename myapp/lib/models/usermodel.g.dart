// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usermodel _$UsermodelFromJson(Map<String, dynamic> json) => Usermodel()
  ..username = json['username'] as String
  ..name = json['name'] as String
  ..password = json['password'] as String
  ..img = json['img'] as String
  ..email = json['email'] as String
  ..phone = json['phone'] as String
  ..facebook = json['facebook'] as String
  ..ig = json['ig'] as String;

Map<String, dynamic> _$UsermodelToJson(Usermodel instance) => <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'password': instance.password,
      'img': instance.img,
      'email': instance.email,
      'phone': instance.phone,
      'facebook': instance.facebook,
      'ig': instance.ig,
    };
