// * CATEGORY
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcampusmarket/features/home/models/category.dart';

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

  // * CREATE
  static Future<bool> addCategories() async {
    final categoriesRef = FirebaseFirestore.instance
        .collection('categories')
        .withConverter(
          fromFirestore: (snapshot, options) => Category.fromJson(snapshot.data()!),
          toFirestore: (category, options) => category.toJson(),
        );

    final List<String> categoryNames = ['생수', '라면', '빵/쿠키', '과일', '유제품', '정육', '과자', '아이스크림'];

    final existingSnapshot = await categoriesRef.get();
    final Set<String> existingCategoryNames =
        existingSnapshot.docs.map((doc) => doc.data().name).toSet();

    final batch = FirebaseFirestore.instance.batch();

    for (String categoryName in categoryNames) {
      if (!existingCategoryNames.contains(categoryName)) {
        final docRef = categoriesRef.doc();
        final category = Category(id: docRef.id, name: categoryName);
        batch.set(docRef, category);
      }
    }
    await batch.commit();

    return true;
  }

  // * READ(STREAM)
  static Stream<List<Category>> watchCategories() {
    final collectionRef = FirebaseFirestore.instance
        .collection('categories')
        .withConverter(
          fromFirestore: (snapshot, options) => Category.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    return collectionRef.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }
}
