// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..username = json['username'] as String
  ..name = json['name'] as String
  ..img = json['img'] as String
  ..phone = json['phone'] as String
  ..email = json['email'] as String
  ..facebook = json['facebook'] as String
  ..ig = json['ig'] as String;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'img': instance.img,
      'phone': instance.phone,
      'email': instance.email,
      'facebook': instance.facebook,
      'ig': instance.ig,
    };
