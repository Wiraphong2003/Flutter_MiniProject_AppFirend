// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Members _$MembersFromJson(Map<String, dynamic> json) => Members()
  ..members = (json['members'] as List<dynamic>)
      .map((e) => Member.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MembersToJson(Members instance) => <String, dynamic>{
      'members': instance.members,
    };
