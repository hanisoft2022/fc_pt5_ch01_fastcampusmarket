import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/features/review/model/review.dart';

class ReviewFirestoreDatasource {
  final FirebaseFirestore firestore;

  ReviewFirestoreDatasource(this.firestore);

  // * CREATE
  Future<void> addReview(Review review) async {
    final reviewsCollectionRef = firestore
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
  }

  Stream<List<Review>> watchReviews(String productId) {
    return firestore
        .collection('products')
        .doc(productId)
        .collection('reviews')
        .withConverter(
          fromFirestore: (snapshot, options) => Review.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
