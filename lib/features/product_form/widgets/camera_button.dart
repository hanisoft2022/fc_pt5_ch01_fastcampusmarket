import 'package:fastcampusmarket/common/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({super.key, required this.image, required this.imageData});

  final ValueNotifier<XFile?> image;
  final ValueNotifier<Uint8List?> imageData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:
          () async => await customImagePicker(
            source: ImageSource.camera,
            image: image,
            imageData: imageData,
          ),
      icon: Icon(Icons.camera_alt_outlined),
    );
  }
}
