import 'package:fastcampusmarket/core/data/datasources/product_remote_datasource.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_provider.g.dart';

@riverpod
Future<List<Product>> products(Ref ref) async {
  return ProductApi.fetchProducts();
}
