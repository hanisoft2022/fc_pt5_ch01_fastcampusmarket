// ignore_for_file: invalid_annotation_target

import 'package:fastcampusmarket/common/utils/converters.dart';
import 'package:fastcampusmarket/features/home/data/models/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  @JsonSerializable(explicitToJson: true)
  const factory Product({
    String? id,
    required String name,
    required String description,
    required Category category,
    required int price,
    required int stock,
    required bool isSale,
    double? saleRate,
    String? imageUrl,
    @CreatedAtField() DateTime? createdAt,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) => _$ProductFromJson(json);
}
