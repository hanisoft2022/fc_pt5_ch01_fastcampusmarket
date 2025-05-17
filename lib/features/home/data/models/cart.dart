import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart.freezed.dart';

part 'cart.g.dart';

@freezed
abstract class Cart with _$Cart {
  const Cart._();

  factory Cart({
    String? id,
    String? uid,
    String? email,
    int? timestamp,
    int? count,
    Product? product,
  }) = _Cart;

  factory Cart.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => Cart.fromJson(snapshot.data() ?? {});

  Map<String, dynamic> toFirestore() => toJson();

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}
