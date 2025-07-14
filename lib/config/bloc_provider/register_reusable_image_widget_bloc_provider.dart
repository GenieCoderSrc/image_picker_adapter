import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it_di_global_variable/get_it_di.dart';
import 'package:image_picker_adapter/view_models/image_picker_cubit/image_picker_cubit.dart';
import 'package:provider/single_child_widget.dart';

// ---- ImagePickerAdapter ------

// late ImageCrudCubit _imageCrudCubit;
late ImagePickerCubit _imagePickerCubit;

void initImagePickerAdapterBlocProvider() {
  // ---- ImagePickerAdapter Init ------
  // _imageCrudCubit = sl<ImageCrudCubit>();
  _imagePickerCubit = sl<ImagePickerCubit>();
}

void disposeImagePickerAdapterBlocProvider() {
  // ---- ImagePickerAdapter Dispose ------
  // _imageCrudCubit.close();
  _imagePickerCubit.close();
}

List<SingleChildWidget> imagePickerAdapterBlocProviders = [
  // ---- ImagePickerAdapter Bloc Provider ------
  // BlocProvider<ImageCrudCubit>(create: (_) => _imageCrudCubit),
  BlocProvider<ImagePickerCubit>(create: (_) => _imagePickerCubit),
];
