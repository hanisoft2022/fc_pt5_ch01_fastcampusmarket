import 'package:fastcampusmarket/core/data/datasources/product_remote_datasource.dart';
import 'package:fastcampusmarket/features/home/models/product.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'seller_providers.g.dart';

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';
  void set(String value) => state = value;
  void clear() => state = '';
}

@riverpod
Stream<List<Product>> productList(Ref ref) {
  final query = ref.watch(searchQueryProvider);
  return ProductApi.watchProducts(
    query,
  ).map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
}
