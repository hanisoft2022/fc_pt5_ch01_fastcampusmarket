import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:flutter/material.dart';

class CategoryApi {
  // * CREATE
  static Future<bool> addCategory(BuildContext context, String category) async {
    final docRef = FirebaseFirestore.instance.collection('categories').doc(category);
    // 기존 카테고리에 존재 여부 확인
    if (await docRef.get().then((value) => value.exists)) {
      return false;
    }

    // 카테고리 등록
    await docRef.set({'name': category, 'createdAt': DateTime.now()});

    return true;
  }

  // * READ
  static Future<List<String>> fetchCategories() async {
    final docRef = FirebaseFirestore.instance.collection('categories');
    final snapshot = await docRef.get();
    final data = snapshot.docs.map((doc) => doc.data()).toList();
    return data.map((item) => item['name'] as String).toList();
  }
}

class ProductApi {
  // * CREATE
  static Future<bool> addProduct(BuildContext context, Product product) async {
    // 카테고리 등록
    final docRef = FirebaseFirestore.instance.collection('products').doc();

    final productWithId = product.copyWith(id: docRef.id);

    // 상품 등록
    await docRef.set({...productWithId.toJson(), 'createdAt': DateTime.now()});
    return true;
  }

  // * READ
  static Future<List<Product>> fetchProducts() async {
    final collectionRef = FirebaseFirestore.instance.collection('products');

    final collectionsSnap = await collectionRef.get();

    return collectionsSnap.docs.map((doc) => Product.fromJson(doc.data())).toList();
  }

  // * READ
  static Stream<QuerySnapshot<Product>> watchProducts(String query) {
    final collectionRef = FirebaseFirestore.instance
        .collection("products")
        .withConverter<Product>(
          fromFirestore: (snapshot, options) => Product.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    if (query.isNotEmpty) {
      return collectionRef.orderBy("name").startAt([query]).endAt(['$query\uf8ff']).snapshots();
    }

    return collectionRef.orderBy('createdAt').snapshots();
  }

  // * DELETE
  static Future<bool> deleteProduct(Product product) async {
    final docRef = FirebaseFirestore.instance.collection('products').doc(product.id);
    await docRef.delete();
    return true;
  }
}
