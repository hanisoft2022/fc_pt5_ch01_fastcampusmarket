import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/core/common/utils/image_compressor.dart';
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

    // Product 도큐먼트의 Category 서브컬렉션에 Category 객체 자체를 저장 (withConverter)
    final categorySubCollectionRef = productDocRef
        .collection('category')
        .withConverter<Category>(
          fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()!),
          toFirestore: (category, _) => category.toJson(),
        );

    // 도큐먼트 id를 category.id로 지정하고 category 객체 저장
    await categorySubCollectionRef.doc(product.category.id).set(product.category);

    // 도큐먼트 id를 자동 생성하고 싶은 경우 아래 코드 사용
    // await categoryCollectionRef.add(product.category);

    // Category 도큐먼트의(서브컬렉션 아님) Product 서브컬렉션에 Product 객체 자체를 저장 (withConverter)
    final categoryCollectionRef = FirebaseFirestore.instance
        .collection('categories')
        .withConverter(
          fromFirestore: (snapshot, options) => Product.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    categoryCollectionRef.doc(product.id).set(product);
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
