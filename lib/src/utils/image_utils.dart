import 'dart:io';

import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageUtils {
  Future<Directory> getCompressedImagesDirectory() async {
    final tempDir = await getTemporaryDirectory();
    final compressedImageDir = Directory('${tempDir.path}/compressed_images');
    if (!compressedImageDir.existsSync()) {
      compressedImageDir.createSync();
    }
    return compressedImageDir;
  }

  Future<void> removedCompressedImagesFromDirectory(String path) async {
    await File(path).delete();
  }

  Future<File?> getCompressedImage(
    File xFile,
    Directory compressedImageDir, {
    int quality = 60,
    bool enforceDelete = false,
  }) async {
    try {
      final comprssesedFile = await FlutterImageCompress.compressAndGetFile(
        xFile.path,
        "${compressedImageDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg",
        quality: quality,
      );
      if (enforceDelete) {
        await xFile.delete();
      }
      if (comprssesedFile != null) {
        return File(comprssesedFile.path);
      }
    } catch (e, stk) {
      print(e);
      print(stk);
      return null;
    }
  }
}
