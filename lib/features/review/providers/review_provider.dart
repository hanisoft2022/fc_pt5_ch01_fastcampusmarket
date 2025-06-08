import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/features/review/data/review_remote_datasource.dart';
import 'package:fastcampusmarket/features/review/model/review.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_provider.g.dart';

@riverpod
ReviewFirestoreDatasource reviewFirestoreDatasource(Ref ref) =>
    ReviewFirestoreDatasource(FirebaseFirestore.instance);

@riverpod
Stream<List<Review>> watchReviews(Ref ref, String productId) {
  final datasource = ref.watch(reviewFirestoreDatasourceProvider);
  return datasource.watchReviews(productId);
}
