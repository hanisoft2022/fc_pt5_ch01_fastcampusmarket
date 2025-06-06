// * PRODUCT
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/common/constants/firestore_collections.dart';
import 'package:fastcampusmarket/common/utils/image_utils.dart';
import 'package:fastcampusmarket/features/home/data/models/category.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:fastcampusmarket/features/home/data/models/product_field_enum.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
        .collection(FirestoreCollections.products)
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
        .collection(FirestoreCollections.category)
        .withConverter<Category>(
          fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()!),
          toFirestore: (category, _) => category.toJson(),
        );

    // 도큐먼트 id를 category.id로 지정하고 category 객체 저장
    await categorySubCollectionRef.doc(updatedProduct.category.id).set(updatedProduct.category);

    // 도큐먼트 id를 자동 생성하고 싶은 경우 아래 코드 사용
    // await categoryCollectionRef.add(product.category);

    // Category 컬렉션의(서브컬렉션 아님) products 서브컬렉션에 Product 객체 자체를 저장 (withConverter)
    final categoryCollectionRef = FirebaseFirestore.instance
        .collection('categories')
        .doc(updatedProduct.category.id);

    final productSubCollectionRef = categoryCollectionRef
        .collection(FirestoreCollections.products)
        .withConverter(
          fromFirestore: (snapshot, options) => Product.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    productSubCollectionRef.doc(updatedProduct.id).set(updatedProduct);
    return true;
  }

  // * CREATE
  static Future<bool> addProducts(Product product, Uint8List imageData) async {
    // image를 Storage에 저장
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child(
      '${DateTime.now().millisecondsSinceEpoch}_${product.name}.jpg',
    );
    final compressedImageData = await compressImageWithUint8List(imageData);
    await imageRef.putData(compressedImageData);

    // imageUrl 가져오기
    final imageUrl = await imageRef.getDownloadURL();

    final batch = FirebaseFirestore.instance.batch();

    for (int i = 0; i < 10; i++) {
      // Product 업데이트하여 Firestore에 저장
      final productDocRef =
          FirebaseFirestore.instance.collection(FirestoreCollections.products).doc();
      // ID , ImageUrl, CreatedAt 업데이트
      // CreatedAt은 null이기 때문에 CreatedAtField Json Converter에 의해 Firebase 서버 시간으로 자동 업데이트됨.
      final updatedProduct = product.copyWith(
        name: product.name + i.toString(),
        id: productDocRef.id,
        imageUrl: imageUrl,
      );
      batch.set(productDocRef, updatedProduct.toJson());

      // Product 도큐먼트의 Category 서브컬렉션에 Category 객체 자체를 저장
      final productCategoryDocRef = productDocRef
          .collection(FirestoreCollections.category)
          .doc(updatedProduct.category.id);
      batch.set(productCategoryDocRef, updatedProduct.category.toJson());

      // Category 도큐먼트의(서브컬렉션 아님) Product 서브컬렉션에 Product 객체 자체를 저장
      final categoryProductDocRef = FirebaseFirestore.instance
          .collection('categories')
          .doc(updatedProduct.category.id)
          .collection('product')
          .doc(updatedProduct.id);
      batch.set(categoryProductDocRef, updatedProduct.toJson());
    }

    await batch.commit();

    return true;
  }

  // * READ
  static Future<List<Product>> fetchProducts() async {
    final collectionRef = FirebaseFirestore.instance
        .collection(FirestoreCollections.products)
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

    return collectionRef.orderBy(ProductField.name.value).snapshots();
  }

  // * READ
  static Future<List<Product>> fetchSaleProducts() async {
    final collectionRef = FirebaseFirestore.instance
        .collection(FirestoreCollections.products)
        .withConverter(
          fromFirestore: (snapshot, options) => Product.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    final querySnapshot =
        await collectionRef
            .where(ProductField.isSale.value, isEqualTo: true)
            .orderBy(ProductField.discountRate.value)
            .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // * UPDATE
  static Future<bool> updateProduct(Product product) async {
    final docRef = FirebaseFirestore.instance
        .collection(FirestoreCollections.products)
        .doc(product.id);

    final updates = product.copyWith(id: product.id).toJson();

    await docRef.update(updates);
    return true;
  }

  // * DELETE
  static Future<bool> deleteProduct(Product product) async {
    final docRef = FirebaseFirestore.instance
        .collection(FirestoreCollections.products)
        .doc(product.id);

    final batch = FirebaseFirestore.instance.batch();

    final categoryCollection = await docRef.collection(FirestoreCollections.category).get();

    for (final doc in categoryCollection.docs) {
      // 1. 해당 product 도큐먼트 category 서브컬렉션의 모든 도큐먼트 삭제
      batch.delete(doc.reference);

      // 2. categories 컬렉션의 해당 product 삭제
      final categoryId = doc.id;

      final categoryProductRef = FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .collection(FirestoreCollections.products)
          .doc(product.id);

      batch.delete(categoryProductRef);
    }

    // 3. product 도큐먼트 삭제
    batch.delete(docRef);

    if (product.imageUrl != null && product.imageUrl!.isNotEmpty) {
      final storageRef = FirebaseStorage.instance.refFromURL(product.imageUrl!);
      await storageRef.delete();
    }

    // 최종 batch 실행
    await batch.commit();

    return true;
  }
}
