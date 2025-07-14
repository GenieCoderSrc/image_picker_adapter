import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

extension XFileParserExtension on XFile {
  /// Converts this XFile to the expected type [T].
  /// Supports File, Uint8List, String (path), and XFile.
  Future<T?> parseAs<T>() async {
    if (T == File) {
      return File(path) as T;
    } else if (T == Uint8List) {
      return await readAsBytes() as T;
    } else if (T == String) {
      return path as T;
    } else if (T == XFile) {
      return this as T;
    } else {
      throw UnsupportedError('Unsupported type conversion: $T');
    }
  }
}
