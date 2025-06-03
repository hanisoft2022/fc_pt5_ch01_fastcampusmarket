import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class CreatedAtField implements JsonConverter<DateTime?, dynamic> {
  const CreatedAtField();

  @override
  DateTime? fromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    return null;
  }

  @override
  dynamic toJson(DateTime? dateTime) {
    // dateTime이 null이면 serverTimestamp()를 반환
    if (dateTime == null) return FieldValue.serverTimestamp();
    return Timestamp.fromDate(dateTime);
  }
}
