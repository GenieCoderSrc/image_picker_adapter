import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class IImageCropperService {
  Future<XFile> cropImage({
    required XFile pickedFile,
    required BuildContext context,
  });
}
