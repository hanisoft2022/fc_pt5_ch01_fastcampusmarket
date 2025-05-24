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
  await docRef.set({'name': category, 'createdAt': FieldValue.serverTimestamp()});

  return true;
}

Future<List<String>> getCategories() async {
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
  await docRef
      .withConverter<Product>(
        fromFirestore: (snapshot, options) => Product.fromJson(snapshot.data()!),
        toFirestore: (product, options) => {...product.toJson()},
      )
      .set(productWithId);
  return true;
}

Future<List<Product>> getProducts() async {
  final collectionRef = FirebaseFirestore.instance
      .collection('products')
      .withConverter<Product>(
        fromFirestore: (snapshot, options) => Product.fromJson(snapshot.data()!),
        toFirestore: (product, options) => product.toJson(),
      );

  final collectionsSnap = await collectionRef.get();

  return collectionsSnap.docs.map((doc) => doc.data()).toList();
}
