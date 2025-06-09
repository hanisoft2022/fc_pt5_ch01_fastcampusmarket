import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/features/home/models/product.dart';
import 'package:fastcampusmarket/features/review/model/review.dart';

class ReviewFirestoreDatasource {
  final FirebaseFirestore firestore;

  ReviewFirestoreDatasource(this.firestore);

  // * CREATE
  Future<void> addReview(Review review) async {
    // 리뷰 추가와 동시에 product의 rating, reviewCount도 갱신함.
    final firestore = FirebaseFirestore.instance;

    // 1. products 컬렉션에 converter 적용
    final productsRef = firestore
        .collection('products')
        .withConverter<Product>(
          fromFirestore: (snap, _) => Product.fromJson(snap.data()!),
          toFirestore: (product, _) => product.toJson(),
        );

    // 2. 특정 product 문서 참조
    final productRef = productsRef.doc(review.productId);

    // 3. reviews 컬렉션에 converter 적용
    final reviewsRef = productRef
        .collection('reviews')
        .withConverter<Review>(
          fromFirestore: (snap, _) => Review.fromJson(snap.data()!),
          toFirestore: (review, _) => review.toJson(),
        );

    // 4. 새로운 review 문서 참조 (id 자동 할당)
    final reviewDocRef = reviewsRef.doc();

    await firestore.runTransaction((transaction) async {
      // 1. Product 객체로 읽기
      final productSnap = await transaction.get(productRef);
      if (!productSnap.exists) throw Exception('Product not found');
      final product = productSnap.data()!;

      final currentRating = product.rating ?? 0;
      final currentReviewCount = product.reviewCount ?? 0;

      // 2. 새로운 평균 평점 계산
      final newReviewCount = currentReviewCount + 1;
      final newRating = ((currentRating * currentReviewCount) + review.rating) / newReviewCount;

      // 3. Product 객체 갱신 및 update
      final updatedProduct = product.copyWith(rating: newRating, reviewCount: newReviewCount);
      transaction.update(productRef, updatedProduct.toJson());

      // 4. Review 객체 id 반영 후 set
      final updatedReview = review.copyWith(id: reviewDocRef.id);
      transaction.set(reviewDocRef, updatedReview);
    });
  }

  // * READ
  Stream<List<Review>> watchReviews(String productId) {
    return firestore
        .collection('products')
        .doc(productId)
        .collection('reviews')
        .orderBy('createdAt', descending: true)
        .withConverter(
          fromFirestore: (snapshot, options) => Review.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
