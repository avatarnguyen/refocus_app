// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserEntry _$$_UserEntryFromJson(Map<String, dynamic> json) => _$_UserEntry(
      id: json['id'] as String,
      username: json['username'] as String?,
      email: json['email'] as String?,
      avatarKey: json['avatarKey'] as String?,
    );

Map<String, dynamic> _$$_UserEntryToJson(_$_UserEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'avatarKey': instance.avatarKey,
    };
