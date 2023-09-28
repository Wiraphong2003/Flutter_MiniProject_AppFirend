// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member()
  ..username = json['username'] as String
  ..name = json['name'] as String
  ..img = json['img'] as String
  ..phone = json['phone'] as String
  ..email = json['email'] as String
  ..facebook = json['facebook'] as String
  ..ig = json['ig'] as String
  ..memo = json['memo'] as String
  ..mood = json['mood'] as String
  ..lat = json['lat'] as String
  ..lng = json['lng'] as String
  ..statusdate = json['statusdate'] as String;

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'img': instance.img,
      'phone': instance.phone,
      'email': instance.email,
      'facebook': instance.facebook,
      'ig': instance.ig,
      'memo': instance.memo,
      'mood': instance.mood,
      'lat': instance.lat,
      'lng': instance.lng,
      'statusdate': instance.statusdate,
    };
