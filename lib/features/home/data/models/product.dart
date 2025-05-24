import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const Product._();

  const factory Product({
    required String id,
    required String name,
    required String description,
    DateTime? createdAt,
    int? price,
    bool? isSale,
    int? stock,
    double? saleRate,
    String? imageUrl,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) => _$ProductFromJson(json);
}
