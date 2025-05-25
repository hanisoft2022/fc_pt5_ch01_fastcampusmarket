// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: json['id'] as String?,
  name: json['name'] as String,
  description: json['description'] as String,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp?,
  ),
  price: (json['price'] as num?)?.toInt(),
  isSale: json['isSale'] as bool?,
  stock: (json['stock'] as num?)?.toInt(),
  saleRate: (json['saleRate'] as num?)?.toDouble(),
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'price': instance.price,
  'isSale': instance.isSale,
  'stock': instance.stock,
  'saleRate': instance.saleRate,
  'imageUrl': instance.imageUrl,
};
