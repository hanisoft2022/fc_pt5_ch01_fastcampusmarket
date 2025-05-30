import 'package:fastcampusmarket/core/common/utils/converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    String? id,
    required String name,
    required String description,
    int? price,
    int? stock,
    bool? isSale,
    double? saleRate,
    String? imageUrl,
    @CreatedAtField() DateTime? createdAt,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) => _$ProductFromJson(json);
}
