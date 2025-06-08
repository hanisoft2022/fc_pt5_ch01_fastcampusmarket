import 'package:fastcampusmarket/common/utils/converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
abstract class Review with _$Review {
  const Review._();

  const factory Review({
    required String? id,
    required String productId,
    required String userId,
    required String review,
    required int rating,
    @CreatedAtField() required DateTime? createdAt,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
