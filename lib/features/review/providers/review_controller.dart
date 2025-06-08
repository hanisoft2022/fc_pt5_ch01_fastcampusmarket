import 'package:fastcampusmarket/features/review/model/review.dart';
import 'package:fastcampusmarket/features/review/providers/review_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_controller.g.dart';

@riverpod
class ReviewController extends _$ReviewController {
  @override
  FutureOr<void> build() {}

  // * CREATE
  Future<void> addReview(Review review) async {
    final datasource = ref.read(reviewFirestoreDatasourceProvider);
    return datasource.addReview(review);
  }
}
