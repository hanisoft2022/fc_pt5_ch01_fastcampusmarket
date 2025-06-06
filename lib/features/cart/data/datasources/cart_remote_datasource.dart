import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/common/constants/firestore_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastcampusmarket/features/cart/data/models/cart_item.dart';
import 'package:fastcampusmarket/features/home/models/product.dart';

class CartApi {
  // * CREATE
  static Future<bool> addToCart(Product product) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인이 필요합니다.');

    final cartItemRef = FirebaseFirestore.instance
        .collection(FirestoreCollections.carts)
        .doc(user.uid)
        .collection('items')
        .doc(product.id)
        .withConverter<CartItem>(
          fromFirestore: (snapshot, options) => CartItem.fromJson(snapshot.data()!),
          toFirestore: (cartItem, options) => cartItem.toJson(),
        );

    final snapshot = await cartItemRef.get();

    if (snapshot.exists) {
      return false;
    } else {
      final newCartItem = CartItem(product: product, quantity: 1, createdAt: null);
      await cartItemRef.set(newCartItem);
      return true;
    }
  }

  // * READ
  static Stream<List<CartItem>> watchCartItems() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인이 필요합니다.');

    return FirebaseFirestore.instance
        .collection('carts')
        .doc(user.uid)
        .collection('items')
        .withConverter<CartItem>(
          fromFirestore: (snapshot, options) => CartItem.fromJson(snapshot.data()!),
          toFirestore: (cartItem, options) => cartItem.toJson(),
        )
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // * UPDATE
  static Future<void> increaseQuantity(Product product) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인이 필요합니다.');

    final cartItemRef = FirebaseFirestore.instance
        .collection(FirestoreCollections.carts)
        .doc(user.uid)
        .collection('items')
        .doc(product.id)
        .withConverter<CartItem>(
          fromFirestore: (snapshot, options) => CartItem.fromJson(snapshot.data()!),
          toFirestore: (cartItem, options) => cartItem.toJson(),
        );

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(cartItemRef);

      final existing = snapshot.data()!;

      final cartItem = snapshot.data()!;
      if (cartItem.quantity! < 99) {
        final updated = existing.copyWith(quantity: existing.quantity! + 1);
        transaction.set(cartItemRef, updated);
      }
    });
  }

  // * UPDATE
  static Future<void> decreaseQuantity(Product product) async {
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

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(cartItemRef);

      final cartItem = snapshot.data()!;
      if (cartItem.quantity != 1) {
        final existing = snapshot.data()!;
        final updated = existing.copyWith(quantity: existing.quantity! - 1);
        transaction.set(cartItemRef, updated);
      } else {
        return;
      }
    });
  }

  // * DELETE
  static Future<void> removeFromCart(Product product) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인이 필요합니다.');

    await FirebaseFirestore.instance
        .collection('carts')
        .doc(user.uid)
        .collection('items')
        .doc(product.id)
        .delete();
  }
}
