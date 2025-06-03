import 'package:fastcampusmarket/common/utils/image_utils.dart';
import 'package:fastcampusmarket/core/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductImagePicker extends StatelessWidget {
  const ProductImagePicker({
    super.key,
    required this.image,
    required this.imageData,
    required this.imageUrl,
  });

  final ValueNotifier<XFile?> image;
  final ValueNotifier<Uint8List?> imageData;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap:
          () async => await customImagePicker(
            source: ImageSource.gallery,
            image: image,
            imageData: imageData,
          ),
      child:
          imageData.value == null
              ? (imageUrl == null
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
                    child: Image.network(
                      imageUrl!,
                      height: context.screenWidth * 0.6,
                      width: context.screenWidth * 0.6,
                      fit: BoxFit.cover,
                    ),
                  ))
              : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.memory(
                  imageData.value!,
                  height: context.screenWidth * 0.6,
                  width: context.screenWidth * 0.6,
                  fit: BoxFit.cover,
                ),
              ),
    );
  }
}
