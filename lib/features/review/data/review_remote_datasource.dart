import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/features/review/model/review.dart';

class ReviewApi {
  // * CREATE
  static Future<bool> createReview(Review review) async {
    final reviewsCollectionRef = FirebaseFirestore.instance
        .collection('products')
        .doc(review.productId)
        .collection('reviews')
        .withConverter(
          fromFirestore: (snapshot, options) => Review.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    final reviewDocRef = reviewsCollectionRef.doc();
    final updatedReview = review.copyWith(id: reviewDocRef.id);
    await reviewDocRef.set(updatedReview);
    return true;
  }
}
