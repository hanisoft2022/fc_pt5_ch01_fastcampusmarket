import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:flutter/material.dart';

Future<bool> addCategory(BuildContext context, String category) async {
  final docRef = FirebaseFirestore.instance.collection('categories').doc(category);
  // 기존 카테고리에 존재 여부 확인
  if (await docRef.get().then((value) => value.exists)) {
    return false;
  }

  // 카테고리 등록
  await docRef.set({'name': category, 'createdAt': DateTime.now()});

  return true;
}

Future<List<String>> fetchCategories() async {
  final docRef = FirebaseFirestore.instance.collection('categories');
  final snapshot = await docRef.get();
  final data = snapshot.docs.map((doc) => doc.data()).toList();
  return data.map((item) => item['name'] as String).toList();
}

Future<bool> addProduct(BuildContext context, Product product) async {
  // 카테고리 등록
  final docRef = FirebaseFirestore.instance.collection('products').doc();

  final productWithId = product.copyWith(id: docRef.id);

  // 상품 등록
  await docRef.set({...productWithId.toJson(), 'createdAt': DateTime.now()});
  return true;
}

Future<List<Product>> fetchProducts() async {
  final collectionRef = FirebaseFirestore.instance.collection('products');

  final collectionsSnap = await collectionRef.get();

  return collectionsSnap.docs.map((doc) => Product.fromJson(doc.data())).toList();
}

Stream<QuerySnapshot> watchProducts(String query) {
  final db = FirebaseFirestore.instance;

  if (query.isNotEmpty) {
    return db.collection("products").orderBy("title").startAt([query]).endAt([
      '$query\uf8ff',
    ]).snapshots();
  }

  return db.collection("products").orderBy('createdAt').snapshots();
}
