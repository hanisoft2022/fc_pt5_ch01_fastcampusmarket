// ignore_for_file: avoid_print

import 'package:fastcampusmarket/core/common/common.dart';
import 'package:fastcampusmarket/core/router/router.dart';
import 'package:fastcampusmarket/features/home/data/models/category.dart';
import 'package:fastcampusmarket/features/home/data/models/product.dart';
import 'package:fastcampusmarket/features/home/presentation/seller/data/firebase_auth_datasource.dart';
import 'package:fastcampusmarket/shared/widgets/custom_snack_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';

final _formKey = GlobalKey<FormState>();

const int maxPrice = 9999999;
const int maxCount = 999;

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

InputDecoration decoration(String name) =>
    InputDecoration(labelText: name, hintText: '$name을(를) 입력하세요.', border: OutlineInputBorder());

class AddProductScreen extends HookWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isSale = useState<bool>(false);

    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final priceController = useTextEditingController();
    final stockController = useTextEditingController();
    final salePercentController = useTextEditingController();

    final image = useState<XFile?>(null);
    final imageData = useState<Uint8List?>(null);

    final categories = useState<List<Category>>([]);
    final isLoading = useState<bool>(true);

    useEffect(() {
      CategoryApi.fetchCategories().then((result) {
        categories.value = result;
        isLoading.value = false;
      });
      return null;
    }, []);

    if (isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    final selectedCategory = useState<Category?>(
      categories.value.isNotEmpty ? categories.value.first : null,
    );

    return Scaffold(
      appBar: AppBar(
        title: '상품 추가'.text.make(),
        actions: [
          IconButton(
            onPressed: () async {
              final picked = await ImagePicker().pickImage(source: ImageSource.camera);

              if (picked != null) {
                image.value = picked;
              }
            },
            icon: Icon(Icons.camera_alt_outlined),
          ),
          TextButton.icon(
            label: '일괄등록'.text.make(),
            onPressed: () {
              if (imageData.value == null) {
                CustomSnackBar.alertSnackBar(context, '제품 이미지를 추가해주세요.');
              }
              if (imageData.value != null) {
                ProductApi.addProductsTestingWithBatch(
                  Product(
                    id: null,
                    name: nameController.text,
                    description: descriptionController.text,
                    category: selectedCategory.value!,
                    price: int.parse(priceController.text),
                    isSale: isSale.value,
                    saleRate: isSale.value ? double.parse(salePercentController.text) : null,
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
              Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      image.value = await ImagePicker().pickImage(source: ImageSource.gallery);
                      imageData.value = await image.value!.readAsBytes();
                    },
                    child:
                        imageData.value == null
                            ? Ink(
                              height: context.screenWidth * 0.6,
                              width: context.screenWidth * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: context.appColors.imageBoxBackgroundColor,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Icon(Icons.add), '제품 이미지 추가'.text.make()],
                              ),
                            )
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.memory(
                                imageData.value!,
                                height: context.screenWidth * 0.6,
                                width: context.screenWidth * 0.6,
                                fit: BoxFit.cover,
                              ),
                            ),
                  ),
                  height20,
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        '카테고리 선택'.text.bold.size(context.textTheme.titleLarge!.fontSize).make(),
                        height25,
                        categories.value.isNotEmpty
                            ? DropdownMenu<Category>(
                              expandedInsets: EdgeInsets.zero,
                              initialSelection: selectedCategory.value,
                              onSelected: (Category? value) {
                                selectedCategory.value = value;
                              },
                              dropdownMenuEntries:
                                  categories.value
                                      .map(
                                        (Category category) => DropdownMenuEntry<Category>(
                                          value: category,
                                          label: category.name,
                                        ),
                                      )
                                      .toList(),
                            )
                            : '선택할 수 있는 카테고리 없음.'.text.make(),
                        height25,
                        // 제품명
                        '제품 정보'.text.bold.size(context.textTheme.titleLarge!.fontSize).make(),
                        height25,
                        // 제품명
                        TextFormField(
                          controller: nameController,
                          decoration: decoration('제품명'),
                          validator: (value) => Validators.requiredValidator(value, '제품명'),
                          textInputAction: TextInputAction.next,
                        ),
                        height15,
                        // 제품 설명
                        TextFormField(
                          controller: descriptionController,
                          decoration: decoration('제품 설명').copyWith(alignLabelWithHint: true),
                          validator: (value) => Validators.requiredValidator(value, '제품 설명'),
                          minLines: 4,
                          maxLines: null,
                          maxLength: 255,
                          keyboardType: TextInputType.multiline,
                        ),
                        height15,
                        // 가격
                        TextFormField(
                          controller: priceController,
                          decoration: decoration(
                            '1개 가격',
                          ).copyWith(suffix: '원'.text.make(), hintText: '최대 금액은 9,999,999원입니다.'),
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => Validators.maxNumberValidator(value, maxPrice),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          textInputAction: TextInputAction.next,
                        ),
                        height15,
                        // 수량
                        TextFormField(
                          controller: stockController,
                          decoration: decoration(
                            '수량',
                          ).copyWith(suffix: '개'.text.make(), hintText: '최대 수량은 $maxCount개입니다.'),
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => Validators.maxNumberValidator(value, maxCount),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          textInputAction: TextInputAction.next,
                        ),
                        height15,

                        // 할인여부
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: '할인 여부'.text.make(),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          value: isSale.value,
                          onChanged: (value) => isSale.value = value,
                        ),
                        height15,
                        if (isSale.value)
                          // 할인율
                          TextFormField(
                            controller: salePercentController,
                            decoration: decoration(
                              '할인율',
                            ).copyWith(hintText: '최대 할인율은 100%입니다.', suffix: '%'.text.make()),
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) => Validators.maxNumberValidator(value, 100),
                          ),
                        height15,
                      ],
                    ),
                  ),
                ],
              ).pSymmetric(h: 20),

              // 제품 추가
              InkWell(
                onTap: () async {
                  if (imageData.value == null) {
                    CustomSnackBar.alertSnackBar(context, '제품 이미지를 추가해주세요.');
                  }
                  if (imageData.value != null) {
                    await ProductApi.addProduct(
                      Product(
                        id: null,
                        name: nameController.text,
                        description: descriptionController.text,
                        category: selectedCategory.value!,
                        price: int.parse(priceController.text),
                        isSale: isSale.value,
                        saleRate: isSale.value ? double.parse(salePercentController.text) : null,
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
                child: Ink(
                  height: 50 + context.bottomPadding,
                  color: Colors.orange,
                  child: Center(
                    child: '제품 추가'.text.bold.size(context.textTheme.titleLarge!.fontSize).make(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
