// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  uid: json['uid'] as String,
  email: json['email'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  displayName: json['displayName'] as String?,
  photoURL: json['photoURL'] as String?,
  provider: json['provider'] as String?,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'createdAt': instance.createdAt.toIso8601String(),
  'displayName': instance.displayName,
  'photoURL': instance.photoURL,
  'provider': instance.provider,
};
