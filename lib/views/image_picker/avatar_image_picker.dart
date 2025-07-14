import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:reusable_image_widget/reusable_image_widget.dart';

import 'app_image_picker.dart';

class AvatarImagePicker extends StatelessWidget {
  const AvatarImagePicker({
    super.key,
    this.imageSource,
    this.onChanged,
    this.imageQuality = 85,
    this.maxHeight = 500,
    this.maxWidth = 500,
    this.crop = false,
    this.compress = true,
    this.cameraEnabled = true,
    this.galleryEnabled = true,
    this.radius = 40,
    this.heroTag,
    this.showEditIcon = true,
    this.isCircleAvatar = true,
    this.onTapEdit,
    this.editIcon,
  });

  /// Local or network image path shown before user picks a new one
  final String? imageSource;

  /// Callback triggered when the image is picked (either file or bytes)
  final void Function(XFile? file)? onChanged;

  /// Controls how much the image should be compressed (0-100)
  final int imageQuality;

  /// Image size constraints
  final double maxHeight;
  final double maxWidth;

  /// Whether to crop the image after picking
  final bool crop;

  /// Whether to compress the image after picking
  final bool compress;

  /// Toggle camera or gallery picker options
  final bool cameraEnabled;
  final bool galleryEnabled;

  /// Avatar display configuration
  final double radius;
  final String? heroTag;
  final bool showEditIcon;
  final bool isCircleAvatar;
  final VoidCallback? onTapEdit;
  final Widget? editIcon;

  @override
  Widget build(BuildContext context) {
    return AppImagePicker(
      imageQuality: imageQuality,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      crop: crop,
      compress: compress,
      cameraEnabled: cameraEnabled,
      galleryEnabled: galleryEnabled,
      onChanged: onChanged,
      builder: (XFile? pickedFile) => EditProfileImageViewer(
        imageSource: imageSource,
        pickedFile: pickedFile,
        radius: radius,
        heroTag: heroTag,
        showEditIcon: showEditIcon,
        isCircleAvatar: isCircleAvatar,
        onTapEdit: onTapEdit,
        editIcon: editIcon,
      ),
    );
  }
}
