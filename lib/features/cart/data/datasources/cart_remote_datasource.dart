import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastcampusmarket/features/cart/data/models/cart_item.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';

class CartApi {
  static Future<void> addToCart(Product product) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인이 필요합니다.');

    final cartItemRef = FirebaseFirestore.instance
        .collection('carts')
        .doc(user.uid)
        .collection('items')
        .doc(product.id)
        .withConverter<CartItem>(
          fromFirestore: (snapshot, options) => CartItem.fromJson(snapshot.data()!),
          toFirestore: (cartItem, options) => cartItem.toJson(),
        );

    // Firestore 트랜잭션으로 수량 증가 처리
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(cartItemRef);

      if (snapshot.exists) {
        // 이미 장바구니에 있으면 수량 증가
        final existing = snapshot.data()!;
        final updated = existing.copyWith(quantity: (existing.quantity ?? 1) + 1);
        transaction.set(cartItemRef, updated);
      } else {
        // 없으면 새로 추가
        final newCartItem = CartItem(product: product, quantity: 1, createdAt: null);
        transaction.set(cartItemRef, newCartItem);
      }
    });
  }
}
