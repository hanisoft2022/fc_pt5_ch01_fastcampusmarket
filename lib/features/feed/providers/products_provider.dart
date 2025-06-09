import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/core/data/datasources/product_remote_datasource.dart';
import 'package:fastcampusmarket/features/home/models/product.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_provider.g.dart';

@riverpod
Future<List<Product>> fetchSaleProducts(Ref ref) async {
  return ProductApi.fetchSaleProducts();
}

@riverpod
Stream<QuerySnapshot<Product>> watchSaleProducts(Ref ref) {
  return ProductApi.watchSaleProducts();
}

@riverpod
Future<List<Product>> fetchProducts(Ref ref) async {
  return ProductApi.fetchProducts();
}

@riverpod
Stream<QuerySnapshot<Product>> watchProducts(Ref ref, String? query) {
  return ProductApi.watchProducts(query);
}
