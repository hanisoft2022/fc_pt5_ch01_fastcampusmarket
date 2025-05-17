import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

part 'category.g.dart';

@freezed
abstract class Category with _$Category {
  const Category._();

  const factory Category({String? id, String? name}) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}
