import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/core/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ReviewDialog extends HookWidget {
  const ReviewDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final selectedRating = useState(1);

    return AlertDialog(
      title: Text('리뷰 등록'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: '리뷰를 입력하세요.',
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
                  onPressed: () {
                    selectedRating.value = index + 1;
                  },
                  icon: Icon(
                    Icons.star,
                    color:
                        index < selectedRating.value
                            ? context.appColors.ratingStarColor
                            : context.appColors.ratingStarEmptyColor,
                  ),
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
