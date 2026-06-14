import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'multi_image_picker.dart';

class GalleryImagePicker extends StatelessWidget {
  const GalleryImagePicker({
    super.key,
    this.onChanged,
    this.imageQuality = 85,
    this.crop = false,
    this.compress = true,
    this.crossAxisCount = 3,
    this.crossAxisSpacing = 8.0,
    this.mainAxisSpacing = 8.0,
    this.headerText = "Upload Gallery Images",
    this.placeholderText = "Add Images",
    this.loadingWidget,
    this.errorWidget,
  });

  final ValueChanged<List<XFile>>? onChanged;
  final int imageQuality;
  final bool crop;
  final bool compress;

  /// Grid Layout configurations
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  /// Text strings
  final String headerText;
  final String placeholderText;

  /// Custom UI placeholders
  final Widget? loadingWidget;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        if (headerText.isNotEmpty) ...[
          Text(
            headerText,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        MultiImagePicker(
          imageQuality: imageQuality,
          crop: crop,
          compress: compress,
          onChanged: onChanged,
          loadingWidget: loadingWidget,
          errorWidget: errorWidget,
          defaultText: placeholderText,
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
        ),
      ],
    );
  }
}
