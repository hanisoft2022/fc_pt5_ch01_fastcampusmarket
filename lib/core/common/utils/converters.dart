import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<Timestamp?, Object?> {
  const TimestampConverter();

  @override
  Timestamp? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json;
    if (json is Map<String, dynamic> && json.containsKey('_seconds')) {
      // Firestore Emulator 등에서 Map 형태로 올 수도 있음
      return Timestamp(json['_seconds'] as int, (json['_nanoseconds'] ?? 0) as int);
    }
    throw Exception('Invalid Timestamp format: $json');
  }

  @override
  Object? toJson(Timestamp? object) => object;
}
