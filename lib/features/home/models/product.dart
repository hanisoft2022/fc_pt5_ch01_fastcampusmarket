// ignore_for_file: invalid_annotation_target

import 'package:fastcampusmarket/common/utils/converters.dart';
import 'package:fastcampusmarket/features/home/models/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const Product._();

  @JsonSerializable(explicitToJson: true)
  const factory Product({
    String? id,
    required String name,
    required String description,
    required Category category,
    required double price,
    required int stock,
    required bool isSale,
    double? discountRate,
    String? imageUrl,
    @CreatedAtField() DateTime? createdAt,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) => _$ProductFromJson(json);

  double get salePrice {
    if (isSale && discountRate != null) {
      // 할인율이 0.2라면 20% 할인
      return price * (1 - discountRate! / 100);
    }
    return price.toDouble();
  }
}
