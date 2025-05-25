import 'package:fastcampusmarket/core/common/utils/converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    String? id,
    required String name,
    required String description,
    @TimestampConverter() DateTime? createdAt,
    int? price,
    bool? isSale,
    int? stock,
    double? saleRate,
    String? imageUrl,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) => _$ProductFromJson(json);
}
