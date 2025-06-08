// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Review _$ReviewFromJson(Map<String, dynamic> json) => _Review(
  id: json['id'] as String?,
  productId: json['productId'] as String,
  userId: json['userId'] as String,
  review: json['review'] as String,
  rating: (json['rating'] as num).toInt(),
  createdAt: const CreatedAtField().fromJson(json['createdAt']),
);

Map<String, dynamic> _$ReviewToJson(_Review instance) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'userId': instance.userId,
  'review': instance.review,
  'rating': instance.rating,
  'createdAt': const CreatedAtField().toJson(instance.createdAt),
};
