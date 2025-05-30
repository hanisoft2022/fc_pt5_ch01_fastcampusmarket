import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/core/common/utils/image_compresser.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fastcampusmarket/features/home/data/models/category.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';

// * CATEGORY
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

// * PRODUCT
class ProductApi {
  // * CREATE
  static Future<bool> addProduct(Product product, Uint8List imageData) async {
    // image를 Storage에 저장
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child(
      '${DateTime.now().millisecondsSinceEpoch}_${product.name}.jpg',
    );
    final compressedImageData = await compressImageWithUint8List(imageData);
    await imageRef.putData(compressedImageData);

    // imageUrl 가져오기
    final imageUrl = await imageRef.getDownloadURL();

    // Product 업데이트하여 Firestore에 저장
    final productsCollectionRef = FirebaseFirestore.instance
        .collection('products')
        .withConverter(
          fromFirestore: (snapshot, options) => Product.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    final productDocRef = productsCollectionRef.doc();
    // ID , ImageUrl, CreatedAt 업데이트
    // CreatedAt은 null이기 때문에 CreatedAtField Json Converter에 의해 Firebase 서버 시간으로 자동 업데이트됨.
    final updatedProduct = product.copyWith(id: productDocRef.id, imageUrl: imageUrl);

    await productDocRef.set(updatedProduct);

    return true;
  }

  // * CREATE
  static Future<bool> addProducts(List<Product> products) async {
    final collectionRef = FirebaseFirestore.instance
        .collection('products')
        .withConverter(
          fromFirestore: (snapshot, options) => Product.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    final batch = FirebaseFirestore.instance.batch();

    for (Product product in products) {
      final docRef = collectionRef.doc();
      final productWithId = product.copyWith(id: docRef.id);
      batch.set(docRef, productWithId);
    }

    await batch.commit();

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
