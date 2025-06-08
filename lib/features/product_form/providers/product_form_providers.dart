import 'package:fastcampusmarket/core/data/datasources/category_remote_datasource.dart';
import 'package:fastcampusmarket/features/home/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_form_providers.g.dart';

@riverpod
Stream<List<Category>> categoryList(Ref ref) => CategoryApi.watchCategories();
