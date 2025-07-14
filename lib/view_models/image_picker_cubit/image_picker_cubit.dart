import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_adapter/application/managers/image_picker_manager.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  final ImagePickerManager imagePickerManager;

  ImagePickerCubit({required this.imagePickerManager})
    : super(ImagePickerInitial());

  Future<void> onPickImage({
    required BuildContext context,
    required bool Function() mounted,
    required ImageSource source,
    bool crop = false,
    bool compress = false,
    int quality = 35,
    double? maxHeight,
    double? maxWidth,
  }) async {
    emit(ImagePickerLoading());

    try {
      final XFile? pickedFile = await imagePickerManager.pickImage(
        context: context,
        mounted: mounted,
        source: source,
        crop: crop,
        compress: compress,
        quality: quality,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      );

      if (pickedFile != null) {
        emit(ImagePickerSuccess(pickedFile: pickedFile));
      } else {
        emit(const ImagePickerFailure('No image selected'));
      }
    } catch (e) {
      emit(ImagePickerFailure('Failed to pick image: $e'));
    }
  }

  void clear() => emit(ImagePickerInitial());
}
