abstract class Validators {
  static String? requiredValidator(String? value, String label) {
    if (value == null || value.isEmpty) {
      return '$label은(는) 필수 항목입니다.';
    }
    return null;
  }

  static String? maxNumberValidator(String? value, int maxCount) {
    if (value == null || value.isEmpty) return '숫자를 입력하세요.';
    final intValue = int.tryParse(value);
    if (intValue == null) return '숫자만 입력하세요.';
    if (intValue > maxCount) return '최대값은 $maxCount입니다. $maxCount 이하로 수정하세요.';
    if (intValue < 1) return '수량은 1개 이상이어야 합니다.';
    return null;
  }
}
