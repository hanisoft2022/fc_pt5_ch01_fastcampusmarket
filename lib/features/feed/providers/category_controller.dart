import 'package:fastcampusmarket/core/data/datasources/category_remote_datasource.dart';
import 'package:fastcampusmarket/features/home/models/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_controller.g.dart';

@riverpod
class CategoryController extends _$CategoryController {
  @override
  String build() => '';

  Future<bool> addCategory(Category category) async {
    final result = await CategoryApi.addCategory(category);
    return result;
  }
}
