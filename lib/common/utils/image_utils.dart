import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List> compressImageWithUint8List(Uint8List uint8List) async {
  return await FlutterImageCompress.compressWithList(uint8List, quality: 50);
}

Future<void> customImagePicker({
  required ImageSource source,
  required ValueNotifier<XFile?> image,
  required ValueNotifier<Uint8List?> imageData,
}) async {
  final picked = await ImagePicker().pickImage(source: source);
  if (picked != null) {
    image.value = picked;
    imageData.value = await picked.readAsBytes();
  }
}
