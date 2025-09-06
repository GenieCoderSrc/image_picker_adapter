import 'dart:io' show Directory; // Safe: only used when not Web

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img; // for web fallback
import 'package:path/path.dart' as p;

import 'i_services/i_image_compressor_service.dart';

class AppImageCompressorService implements IImageCompressorService {
  @override
  Future<XFile> compressImage(XFile pickedFile, {int quality = 35}) async {
    try {
      if (kIsWeb) {
        // Web fallback: compress with `image` package
        final bytes = await pickedFile.readAsBytes();
        final decoded = img.decodeImage(bytes);
        if (decoded == null) return pickedFile;

        final compressedBytes = img.encodeJpg(decoded, quality: quality);

        final compressedXFile = XFile.fromData(
          compressedBytes,
          name: pickedFile.name,
        );

        debugPrint(
          'Compress (web): original=${bytes.length} compressed=${compressedBytes.length}',
        );

        return compressedXFile;
      } else {
        // Mobile / Desktop (using flutter_image_compress)
        final String tempDir = (await getTemporaryDirectory()).path;
        final String targetPath = p.join(
          tempDir,
          '${DateTime.now().millisecondsSinceEpoch}${p.extension(pickedFile.path)}',
        );

        final XFile? compressed = await FlutterImageCompress.compressAndGetFile(
          pickedFile.path,
          targetPath,
          quality: quality,
        );

        debugPrint(
          'Compress: original=${await pickedFile.length()} compressed=${await compressed?.length()}',
        );

        return compressed ?? pickedFile;
      }
    } catch (e) {
      debugPrint('AppImageCompressorService | error: $e');
      return pickedFile;
    }
  }

  Future<Directory> getTemporaryDirectory() async {
    return Directory.systemTemp;
  }
}
