import 'package:fastcampusmarket/common/widgets/custom_snack_bar.dart';
import 'package:fastcampusmarket/core/extensions/context.dart';
import 'package:fastcampusmarket/features/home/models/product.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.product,
    required this.isLoading,
    required this.onAddToCart,
  });

  final Product product;
  final bool isLoading;
  final Future<bool> Function(Product) onAddToCart;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          isLoading
              ? null
              : () async {
                try {
                  final bool isAdded = await onAddToCart(product);

                  if (isAdded) {
                    if (context.mounted) {
                      CustomSnackBar.successSnackBar(context, '${product.name}을 장바구니에 담았습니다.');
                    }
                  } else {
                    if (context.mounted) {
                      CustomSnackBar.alertSnackBar(context, '이미 장바구니에 상품이 있습니다.');
                    }
                  }
                } catch (e) {
                  if (context.mounted) {
                    CustomSnackBar.failureSnackBar(context, '${product.name}을 장바구니 담지 못했습니다.');
                  }
                }
              },
      child: Ink(
        height: 50 + context.bottomPadding,
        color: Colors.orange,
        child: Center(
          child:
              isLoading
                  ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                  : '장바구니 담기'.text.bold.size(context.textTheme.titleLarge!.fontSize).make(),
        ),
      ),
    );
  }
}
