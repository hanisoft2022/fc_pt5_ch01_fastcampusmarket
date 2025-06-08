import 'package:fastcampusmarket/core/data/datasources/category_remote_datasource.dart';
import 'package:fastcampusmarket/features/home/models/category.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_provider.g.dart';

@riverpod
Stream<List<Category>> categories(Ref ref) {
  return CategoryApi.watchCategories();
}
