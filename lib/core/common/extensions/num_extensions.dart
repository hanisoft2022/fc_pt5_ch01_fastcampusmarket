import 'package:intl/intl.dart';

final decimalFormat = NumberFormat.decimalPattern();

extension IntExtensions on int {
  static int? safeParse(String? source) {
    if (source == null) return null;
    return int.tryParse(source);
  }

  String toComma() {
    return decimalFormat.format(this);
  }

  String toWon() => "${toComma()}원";

  String get withPlusMinus {
    if (this > 0) {
      return "+$this";
    } else if (this < 0) {
      return "$this";
    } else {
      return "0";
    }
  }
}

extension DoubleExtensions on double {
  String toComma() {
    return decimalFormat.format(this);
  }
}
