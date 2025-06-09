import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/features/cart/providers/cart_controller.dart';
import 'package:fastcampusmarket/features/feed/providers/products_provider.dart';
import 'package:fastcampusmarket/features/product%20detail/widgets/add_to_cart_button.dart';
import 'package:fastcampusmarket/features/product%20detail/widgets/price_and_ratings_row.dart';
import 'package:fastcampusmarket/features/product%20detail/widgets/product_description_section.dart';
import 'package:fastcampusmarket/features/product%20detail/widgets/product_detail_and_review_tab.dart';
import 'package:fastcampusmarket/features/product%20detail/widgets/product_image_banner.dart';
import 'package:fastcampusmarket/features/product%20detail/widgets/product_title_menu_row.dart';
import 'package:fastcampusmarket/features/review/providers/review_provider.dart';
import 'package:fastcampusmarket/features/review/views/review_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(watchProductsProvider(null));
    final cartState = ref.watch(cartControllerProvider);
    final reviewAsync = ref.watch(watchReviewsProvider(productId));

    return productsAsync.when(
      data: (products) {
        final product = products.docs
            .map((doc) => doc.data())
            .firstWhere((product) => product.id == productId);

        return Scaffold(
          appBar: AppBar(title: product.name.text.make()),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ProductImageBanner(imageUrl: product.imageUrl!, isSale: product.isSale),
                height10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductTitleMenuRow(
                      onReviewTap:
                          () => showDialog(
                            context: context,
                            builder: (context) => ReviewDialog(product.id!),
                          ),
                      productName: product.name,
                    ),
                    height15,
                    ProductDescriptionSection(title: '제품 상세 정보 ', description: product.description),
                    height15,
                    PriceAndRatingsRow(
                      price: product.price,
                      reviewCount: product.reviewCount,
                      rating: product.rating,
                    ),
                    ProductDetailAndReviewTab(reviewAsync: reviewAsync),
                  ],
                ).pSymmetric(h: 15),
                AddToCartButton(
                  product: product,
                  isLoading: cartState.isLoading,
                  onAddToCart:
                      (product) => ref.read(cartControllerProvider.notifier).addToCart(product),
                ),
              ],
            ),
          ),
        );
      },
      error:
          (error, stackTrace) =>
              Scaffold(appBar: AppBar(), body: Center(child: 'error'.text.make())),
      loading: () => Scaffold(appBar: AppBar(), body: Center(child: CircularProgressIndicator())),
    );
  }
}
