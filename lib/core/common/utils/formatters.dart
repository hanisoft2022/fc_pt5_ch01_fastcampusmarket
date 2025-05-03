import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CommaTextInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter;
  final int maxValue;

  CommaTextInputFormatter({String locale = 'ko_KR', this.maxValue = 10000000000})
    : _formatter = NumberFormat.decimalPattern(locale);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // 1. 입력값에서 숫자만 추출
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return newValue.copyWith(text: '');

    // TODO: 최대값 제한 로직 다시 구현하기. 디버그 콘솔에 여전히 에러 뜸.
    // 최대값 제한
    int value = int.tryParse(digits) ?? 0;
    if (value > maxValue) {
      value = maxValue;
    }
    // 2. 콤마 추가
    String newText = _formatter.format(int.parse(digits));

    // 3. 커서 위치를 항상 맨 뒤로 이동
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
