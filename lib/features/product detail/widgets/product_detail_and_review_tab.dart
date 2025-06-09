import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/features/review/model/review.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:fastcampusmarket/core/extensions/date_extensions.dart';

class ProductDetailAndReviewTab extends StatelessWidget {
  const ProductDetailAndReviewTab({super.key, required this.reviewAsync});

  final AsyncValue<List<Review>> reviewAsync;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            splashBorderRadius: BorderRadius.circular(10),
            tabs: [
              Tab(icon: Icon(Icons.insert_drive_file_outlined), child: '상품정보'.text.make()),
              Tab(icon: Icon(Icons.rate_review_outlined), child: '리뷰'.text.make()),
            ],
          ),
          height15,
          SizedBox(
            height: 400,
            child: TabBarView(
              children: [
                Center(child: '상품정보'.text.make()),
                reviewAsync.when(
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: '리뷰를 불러오지 못했습니다.'.text.make()),
                  data: (reviews) {
                    if (reviews.isEmpty) {
                      return Center(child: '아직 리뷰가 없습니다.'.text.make());
                    }
                    return ListView.separated(
                      itemCount: reviews.length,
                      separatorBuilder: (context, index) => Divider(height: 1),
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return ListTile(
                          title: review.review.text.make(),
                          trailing: '평점: ${review.rating}'.text.make(),
                          subtitle: '작성일: ${review.createdAt!.koreanDate}'.text.make(),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
