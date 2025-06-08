import 'package:fastcampusmarket/features/review/model/review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/review_remote_datasource.dart';

part 'review_controller.g.dart';

@riverpod
class ReviewController extends _$ReviewController {
  @override
  FutureOr<void> build() {}

  // * CREATE
  Future<bool> createReview(Review review) async => ReviewApi.createReview(review);
}
