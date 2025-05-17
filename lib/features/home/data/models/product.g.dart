// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  price: (json['price'] as num?)?.toInt(),
  isSale: json['isSale'] as bool?,
  stock: (json['stock'] as num?)?.toInt(),
  saleRate: (json['saleRate'] as num?)?.toDouble(),
  imageUrl: json['imageUrl'] as String?,
  timeStamp: (json['timeStamp'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'price': instance.price,
  'isSale': instance.isSale,
  'stock': instance.stock,
  'saleRate': instance.saleRate,
  'imageUrl': instance.imageUrl,
  'timeStamp': instance.timeStamp,
};
