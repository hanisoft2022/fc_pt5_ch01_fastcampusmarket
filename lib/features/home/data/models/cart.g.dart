// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Cart _$CartFromJson(Map<String, dynamic> json) => _Cart(
  id: json['id'] as String?,
  uid: json['uid'] as String?,
  email: json['email'] as String?,
  timestamp: (json['timestamp'] as num?)?.toInt(),
  count: (json['count'] as num?)?.toInt(),
  product:
      json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CartToJson(_Cart instance) => <String, dynamic>{
  'id': instance.id,
  'uid': instance.uid,
  'email': instance.email,
  'timestamp': instance.timestamp,
  'count': instance.count,
  'product': instance.product,
};
