import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_adapter/services/crop_aspect_ratio_preset_custom.dart';

import 'i_services/i_image_cropper_service.dart';

class AppImageCropperService implements IImageCropperService {
  @override
  Future<XFile> cropImage({
    required XFile pickedFile,
    required BuildContext context,
  }) async {
    try {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPresetCustom(),
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPresetCustom(),
            ],
          ),
          WebUiSettings(context: context),
        ],
      );

      return croppedFile != null ? XFile(croppedFile.path) : pickedFile;
    } catch (e) {
      debugPrint('AppImageCropperService | error: $e');
      return pickedFile;
    }
  }
}
