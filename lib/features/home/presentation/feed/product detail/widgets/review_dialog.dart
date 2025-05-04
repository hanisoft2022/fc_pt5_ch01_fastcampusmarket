import 'package:fastcampusmarket/core/common/extensions/extensions.dart';
import 'package:fastcampusmarket/core/common/widgets/height_width_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReviewDialog extends StatelessWidget {
  const ReviewDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('리뷰 등록'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            minLines: 4,
            maxLines: null,
            maxLength: 255,
          ),
          height10,
          Text('별을 눌러 평점을 매겨주세요.'),
          Row(
            children: [
              ...List.generate(
                5,
                (index) => IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.star, color: context.appColors.ratingStarColor),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: Text('취소')),
        TextButton(onPressed: () {}, child: Text('등록')),
      ],
    );
  }
}
