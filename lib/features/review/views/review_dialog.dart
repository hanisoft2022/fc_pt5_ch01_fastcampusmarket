import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/core/extensions/context.dart';
import 'package:fastcampusmarket/features/review/model/review.dart';
import 'package:fastcampusmarket/features/review/providers/review_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReviewDialog extends HookConsumerWidget {
  const ReviewDialog(this.productId, {super.key});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewTEC = useTextEditingController();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final selectedRating = useState(1);

    return AlertDialog(
      title: Text('리뷰 등록'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: reviewTEC,
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
        TextButton(
          onPressed: () async {
            await ref
                .watch(reviewControllerProvider.notifier)
                .addReview(
                  Review(
                    userId: userId,
                    id: null,
                    productId: productId,
                    rating: selectedRating.value,
                    review: reviewTEC.text,
                    createdAt: null,
                  ),
                );
            if (context.mounted) {
              context.pop();
            }
          },
          child: Text('등록'),
        ),
      ],
    );
  }
}
