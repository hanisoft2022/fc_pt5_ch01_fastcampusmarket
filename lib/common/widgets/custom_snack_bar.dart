import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:flutter/material.dart';

abstract class CustomSnackBar {
  // 성공
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
            child: Text(message, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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

  // 실패
  static void failureSnackBar(BuildContext context, String message) {
    // 기존에 스낵바가 존재할 경우 제거
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // 스낵바
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.cancel, color: Colors.white, size: 28),
          width15,
          Expanded(
            child: Text(message, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      backgroundColor: Colors.red[600],
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 10,
      duration: Duration(seconds: 2),
      // margin: EdgeInsets.only(bottom: 50, left: 20, right: 20),
    );

    // 스낵바 띄우기
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // 경고
  static void alertSnackBar(BuildContext context, String message) {
    // 기존에 스낵바가 존재할 경우 제거
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // 스낵바
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.white, size: 28),
          width15,
          Expanded(
            child: Text(message, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
      backgroundColor: Colors.deepOrangeAccent,
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
