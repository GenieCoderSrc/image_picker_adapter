part of 'image_picker_cubit.dart';

sealed class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object?> get props => [];
}

class ImagePickerInitial extends ImagePickerState {}

class ImagePickerLoading extends ImagePickerState {}

class ImagePickerSuccess extends ImagePickerState {
  final XFile? pickedFile;

  const ImagePickerSuccess({this.pickedFile});

  @override
  List<Object?> get props => [pickedFile?.path];
}

class ImagePickerFailure extends ImagePickerState {
  final String message;

  const ImagePickerFailure(this.message);

  @override
  List<Object> get props => [message];
}
