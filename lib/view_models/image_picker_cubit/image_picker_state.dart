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

class ImagePickerMultiSuccess extends ImagePickerState {
  final List<XFile> pickedFiles;

  const ImagePickerMultiSuccess({required this.pickedFiles});

  @override
  List<Object?> get props => [pickedFiles.map((f) => f.path).toList()];
}

class ImagePickerFailure extends ImagePickerState {
  final String message;

  const ImagePickerFailure(this.message);

  @override
  List<Object> get props => [message];
}
