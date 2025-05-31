import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List> compressImageWithUint8List(Uint8List uint8List) async {
  return await FlutterImageCompress.compressWithList(uint8List, quality: 50);
}
