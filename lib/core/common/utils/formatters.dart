import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// 숫자에 콤마 붙여주는 formatter
// ! 백엔드 전송 전 아래와 같이 콤마 제하는 로직 구현 필수
//  * final textNum = numTextController.text.replaceAll(',', '');
//  * final num = int.parse(price);
class AddCommaToIntTextInputFormatter extends TextInputFormatter {
  final NumberFormat formatter;
  final int maxValue;

  AddCommaToIntTextInputFormatter({String locale = 'ko_KR', this.maxValue = 9999999})
    : formatter = NumberFormat.decimalPattern(locale);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return newValue.copyWith(text: '');

    BigInt value = BigInt.parse(digits);
    BigInt max = BigInt.from(maxValue);

    if (value > max) value = max;

    String newText = formatter.format(value.toInt());

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

// 최댓값 제한 formatter
// ! 최댓값 초과 시 입력값이 자동으로 최댓값으로 변경되는 로직 포함
class SetMaxValueTextInputFormatter extends TextInputFormatter {
  final int maxValue;

  SetMaxValueTextInputFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return newValue.copyWith(text: '');

    int value = int.tryParse(digits) ?? 0;
    if (value > maxValue) value = maxValue;

    final text = value.toString();

    // 변경된 값과 커서 위치 반환
    return TextEditingValue(
      text: text.toString(),
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
