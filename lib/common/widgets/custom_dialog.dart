import 'package:flutter/material.dart';

class QuestionDialog extends StatelessWidget {
  const QuestionDialog({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      icon: Icon(Icons.question_mark),
      actions: [
        TextButton(child: const Text('확인'), onPressed: () => Navigator.of(context).pop()),
        TextButton(child: const Text('취소'), onPressed: () => Navigator.of(context).pop()),
      ],
    );
  }
}
