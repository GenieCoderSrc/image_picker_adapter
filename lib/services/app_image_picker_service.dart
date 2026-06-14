import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage({
    required ImageSource source,
    int? imageQuality,
    double? maxHeight,
    double? maxWidth,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: imageQuality,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      );

      return pickedFile;
    } catch (e) {
      debugPrint('AppImagePickerService | error: $e');
      return null;
    }
  }

  Future<List<XFile>> pickMultiImage() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      return pickedFiles;
    } catch (e) {
      debugPrint('AppImagePickerService | pickMultiImage error: $e');
      return [];
    }
  }
}
