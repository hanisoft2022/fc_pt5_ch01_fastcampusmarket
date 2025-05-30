// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: json['id'] as String?,
  name: json['name'] as String,
  description: json['description'] as String,
  category: Category.fromJson(json['category'] as Map<String, dynamic>),
  price: (json['price'] as num).toInt(),
  stock: (json['stock'] as num).toInt(),
  isSale: json['isSale'] as bool,
  saleRate: (json['saleRate'] as num?)?.toDouble(),
  imageUrl: json['imageUrl'] as String?,
  createdAt: const CreatedAtField().fromJson(json['createdAt']),
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'category': instance.category.toJson(),
  'price': instance.price,
  'stock': instance.stock,
  'isSale': instance.isSale,
  'saleRate': instance.saleRate,
  'imageUrl': instance.imageUrl,
  'createdAt': const CreatedAtField().toJson(instance.createdAt),
};
