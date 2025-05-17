import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    required String title,
    required String description,
    int? price,
    bool? isSale,
    int? stock,
    double? saleRate,
    String? imageUrl,
    int? timeStamp,
  }) = _Product;

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => Product.fromJson(snapshot.data() ?? {});

  factory Product.fromJson(Map<String, Object?> json) => _$ProductFromJson(json);
}
