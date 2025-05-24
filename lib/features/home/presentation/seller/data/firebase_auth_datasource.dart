import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<bool> addCategory(BuildContext context, String category) async {
  // 기존 카테고리에 존재 여부 확인
  if (await FirebaseFirestore.instance
      .collection('categories')
      .doc(category)
      .get()
      .then((value) => value.exists)) {
    return true;
  }

  // 카테고리 등록
  await FirebaseFirestore.instance.collection('categories').doc(category).set({
    'name': category,
    'createdAt': Timestamp.now(),
  });

  return true;
}

Future<List<String>> getCategories() async {
  final docRef = FirebaseFirestore.instance.collection('categories');
  final snapshot = await docRef.get();
  final data = snapshot.docs.map((doc) => doc.data()).toList();
  return data.map((item) => item['name'] as String).toList();
}
