import 'package:intl/intl.dart';

final koreanFormat = DateFormat('yyyy년 M월 d일 HH시 mm분', 'ko');

extension DateTimeExtension on DateTime {
  String get koreanDate => koreanFormat.format(this);
}

extension StringExtension on String {
  String get koreanDate => DateFormat('yyyy년 M월 d일 HH:mm', 'ko').format(DateTime.parse(this));
}
