import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart.freezed.dart';

part 'cart.g.dart';

@freezed
abstract class Cart with _$Cart {
  const Cart._();

  const factory Cart({
    String? id,
    String? uid,
    String? email,
    int? timestamp,
    int? count,
    Product? product,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}
