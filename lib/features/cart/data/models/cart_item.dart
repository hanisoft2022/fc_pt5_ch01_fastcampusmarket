import 'package:fastcampusmarket/common/utils/converters.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
abstract class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    Product? product,
    @Default(1) int? quantity,
    @CreatedAtField() DateTime? createdAt,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
}
