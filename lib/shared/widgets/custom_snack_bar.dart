import 'package:fastcampusmarket/core/common/widgets/height_width_widgets.dart';
import 'package:flutter/material.dart';

abstract class CustomSnackBar {
  static void successSnackBar(BuildContext context, String message) {
    // 기존에 스낵바가 존재할 경우 제거
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // 스낵바
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.white, size: 28),
          width15,
          Expanded(
            child: Text(
              '$message에 성공했습니다.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green[600],
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 10,
      duration: Duration(seconds: 2),
      // margin: EdgeInsets.only(bottom: 50, left: 20, right: 20),
    );

    // 스낵바 띄우기
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
