// 📄 services/i_image_source_selector_service.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class IImageSourceSelectorService {
  void selectImageSource({
    required BuildContext context,
    required bool cameraEnabled,
    required bool galleryEnabled,
    required void Function(ImageSource source) onSourceSelected,
  });
}
