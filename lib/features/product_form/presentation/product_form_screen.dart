import 'package:fastcampusmarket/common/widgets/height_width_widgets.dart';
import 'package:fastcampusmarket/core/data/datasources/product_remote_datasource.dart';
import 'package:fastcampusmarket/core/router/router.dart';
import 'package:fastcampusmarket/features/home/models/category.dart';
import 'package:fastcampusmarket/features/home/models/product.dart';
import 'package:fastcampusmarket/common/widgets/custom_snack_bar.dart';
import 'package:fastcampusmarket/features/product_form/presentation/widgets/camera_button.dart';
import 'package:fastcampusmarket/features/product_form/presentation/widgets/product_category_dropdown.dart';
import 'package:fastcampusmarket/features/product_form/presentation/widgets/product_form_providers.dart';
import 'package:fastcampusmarket/features/product_form/presentation/widgets/product_image_picker.dart';
import 'package:fastcampusmarket/features/product_form/presentation/widgets/product_name_field.dart';
import 'package:fastcampusmarket/features/product_form/presentation/widgets/product_price_field.dart';
import 'package:fastcampusmarket/features/product_form/presentation/widgets/product_sale_field.dart';
import 'package:fastcampusmarket/features/product_form/presentation/widgets/product_stock_field.dart';
import 'package:fastcampusmarket/features/product_form/presentation/widgets/product_submit_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fastcampusmarket/features/product_form/presentation/product_form_providers.dart';

class ProductFormScreen extends HookConsumerWidget {
  final Product? initialProduct;

  const ProductFormScreen({super.key, this.initialProduct});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * 입력 컨트롤러
    final nameController = useTextEditingController(text: initialProduct?.name ?? '');
    final descriptionController = useTextEditingController(text: initialProduct?.description ?? '');
    final priceController = useTextEditingController(text: initialProduct?.price.toString() ?? '');
    final stockController = useTextEditingController(text: initialProduct?.stock.toString() ?? '');
    final salePercentController = useTextEditingController(
      text: initialProduct?.discountRate.toString() ?? '',
    );

    // * UI 상태 변수
    final isSale = useState<bool>(initialProduct?.isSale ?? false);
    final selectedCategory = useState<Category?>(null);

    // * 이미지 관련 상태
    final image = useState<XFile?>(null);
    final imageData = useState<Uint8List?>(null);
    final String? imageUrl = initialProduct?.imageUrl;

    // * 카테고리 목록(비동기)
    final categoryListAsync = ref.watch(categoryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: '상품 추가'.text.make(),
        actions: [
          CameraButton(image: image, imageData: imageData),
          TextButton.icon(
            label: '일괄등록'.text.make(),
            onPressed: () {
              if (imageData.value == null) {
                CustomSnackBar.alertSnackBar(context, '제품 이미지를 추가해주세요.');
              }
              if (imageData.value != null) {
                ProductApi.addProducts(
                  Product(
                    id: null,
                    name: nameController.text,
                    description: descriptionController.text,
                    category: selectedCategory.value!,
                    price: double.parse(priceController.text),
                    isSale: isSale.value,
                    discountRate: isSale.value ? double.parse(salePercentController.text) : null,
                    stock: int.parse(stockController.text),
                    imageUrl: null,
                    createdAt: null,
                  ),
                  imageData.value!,
                );
                if (context.mounted) {
                  context.goNamed(SellerRoute.name);
                }
              }
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              // 이미지, 카테고리, 제품 정보 입력란
              Column(
                children: [
                  // 이미지 선택
                  ProductImagePicker(image: image, imageData: imageData, imageUrl: imageUrl),
                  height20,
                  // 카테고리, 제품 정보 입력란
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 카테고리 선택
                        '카테고리 선택'.text.bold.size(context.textTheme.titleLarge!.fontSize).make(),
                        height25,
                        categoryListAsync.when(
                          loading: () => Center(child: CircularProgressIndicator()),
                          error: (error, stackTrace) => Center(child: Text(error.toString())),
                          data: (categories) {
                            return ProductCategoryDropdown(
                              categories: categories,
                              selectedCategory: selectedCategory.value,
                              onSelected: (Category? value) {
                                selectedCategory.value = value;
                              },
                            );
                          },
                        ),
                        height25,
                        // 제품 정보
                        '제품 정보'.text.bold.size(context.textTheme.titleLarge!.fontSize).make(),
                        height25,
                        // 제품명
                        ProductNameField(nameController: nameController),
                        height15,
                        // 제품 설명
                        ProductDescriptionField(descriptionController: descriptionController),
                        height15,
                        // 가격
                        ProductPriceField(priceController: priceController),
                        height15,
                        // 수량
                        ProductStockField(stockController: stockController),
                        height15,
                        // 할인
                        ProductSaleField(
                          isSale: isSale.value,
                          onSaleChanged: (value) => isSale.value = value,
                          salePercentController: salePercentController,
                        ),
                        height15,
                      ],
                    ),
                  ),
                ],
              ).pSymmetric(h: 20),
              // 제품 추가 버튼
              ProductSubmitButton(
                onSubmit: () async {
                  if (imageData.value == null && imageUrl == null) {
                    CustomSnackBar.alertSnackBar(context, '제품 이미지를 추가해주세요.');
                    return;
                  }
                  if (initialProduct == null) {
                    await ProductApi.addProduct(
                      Product(
                        id: null,
                        name: nameController.text,
                        description: descriptionController.text,
                        category: selectedCategory.value!,
                        price: double.parse(priceController.text),
                        isSale: isSale.value,
                        discountRate:
                            isSale.value ? double.parse(salePercentController.text) : null,
                        stock: int.parse(stockController.text),
                        imageUrl: null,
                        createdAt: null,
                      ),
                      imageData.value!,
                    );
                  } else {
                    await ProductApi.updateProduct(
                      initialProduct!.copyWith(
                        name: nameController.text,
                        description: descriptionController.text,
                        category: selectedCategory.value!,
                        price: double.parse(priceController.text),
                        isSale: isSale.value,
                        discountRate:
                            isSale.value ? double.parse(salePercentController.text) : null,
                        stock: int.parse(stockController.text),
                      ),
                    );
                  }
                  if (context.mounted) {
                    context.goNamed(SellerRoute.name);
                  }
                },
                isEdit: initialProduct != null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final _formKey = GlobalKey<FormState>();

const int maxPrice = 9999999;
const int maxCount = 999;

InputDecoration decoration(String name) =>
    InputDecoration(labelText: name, hintText: '$name을(를) 입력하세요.', border: OutlineInputBorder());
