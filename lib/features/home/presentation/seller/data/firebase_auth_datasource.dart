import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/features/home/data/models/category.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:flutter/material.dart';

class CategoryApi {
  // * CREATE
  static Future<bool> addCategory(Category category) async {
    final categoriesRef = FirebaseFirestore.instance
        .collection('categories')
        .withConverter(
          fromFirestore: (snapshot, options) => Category.fromJson(snapshot.data()!),
          toFirestore: (category, options) => category.toJson(),
        );

    // 기존 카테고리에 존재 여부 확인
    final duplicateQuery = await categoriesRef.where('name', isEqualTo: category.name).get();
    if (duplicateQuery.docs.isNotEmpty) {
      return false;
    }

    final docRef = categoriesRef.doc();

    final categoryWithId = category.copyWith(id: docRef.id);

    // 카테고리 등록
    await docRef.set(categoryWithId);

    return true;
  }

  // * READ
  static Future<List<Category>> fetchCategories() async {
    final collectionRef = FirebaseFirestore.instance
        .collection('categories')
        .withConverter(
          fromFirestore: (snapshot, options) => Category.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    final snapshot = await collectionRef.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}

class ProductApi {
  // * CREATE
  static Future<bool> addProduct(Product product) async {
    final collectionRef = FirebaseFirestore.instance
        .collection('products')
        .withConverter(
          fromFirestore: (snapshot, options) => Product.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    final docRef = collectionRef.doc();
    final productWithId = product.copyWith(id: docRef.id);
    await docRef.set(productWithId);
    return true;
  }

  // * READ
  static Future<List<Product>> fetchProducts() async {
    final collectionRef = FirebaseFirestore.instance
        .collection('products')
        .withConverter(
          fromFirestore: (snapshot, options) => Product.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    final collectionsSnap = await collectionRef.get();

    return collectionsSnap.docs.map((doc) => doc.data()).toList();
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
