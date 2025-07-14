// 📄 services/i_image_source_selector_service.dart

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_adapter/enums/source_selector_style.dart';

import '../i_services/i_image_source_selector_service.dart';
import 'present_source_selector_ui.dart';

class ImageSourceSelectorService implements IImageSourceSelectorService {
  const ImageSourceSelectorService({
    this.style = SourceSelectorStyle.bottomSheet,
  });

  final SourceSelectorStyle style;

  @override
  void selectImageSource({
    required BuildContext context,
    required bool cameraEnabled,
    required bool galleryEnabled,
    required void Function(ImageSource source) onSourceSelected,
    Widget? customSelector,
  }) {
    if (cameraEnabled && galleryEnabled) {
      presentSourceSelectorUI(
        context: context,
        onSelected: onSourceSelected,
        customSelector: customSelector,
        style: style,
      );
    } else {
      onSourceSelected(ImageSource.gallery);
    }
  }
}
