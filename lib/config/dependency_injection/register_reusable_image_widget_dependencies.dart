import 'package:get_it_di_global_variable/get_it_di.dart';
import 'package:image_picker_adapter/application/managers/image_picker_manager.dart';
import 'package:image_picker_adapter/services/app_image_compressor_service.dart';
import 'package:image_picker_adapter/services/app_image_cropper_service.dart';
import 'package:image_picker_adapter/services/app_image_picker_service.dart';
import 'package:image_picker_adapter/services/i_services/i_image_compressor_service.dart';
import 'package:image_picker_adapter/services/i_services/i_image_cropper_service.dart';
import 'package:image_picker_adapter/view_models/image_picker_cubit/image_picker_cubit.dart';

void registerImagePickerAdapterDependencies() {
  // --- Services ---
  sl.registerLazySingleton<AppImagePickerService>(
    () => AppImagePickerService(),
  );
  sl.registerLazySingleton<IImageCropperService>(
    () => AppImageCropperService(),
  );
  sl.registerLazySingleton<IImageCompressorService>(
    () => AppImageCompressorService(),
  );

  sl.registerLazySingleton<ImagePickerManager>(
    () => ImagePickerManager(
      pickerService: sl<AppImagePickerService>(),
      cropperService: sl<IImageCropperService>(),
      compressorService: sl<IImageCompressorService>(),
    ),
  );

  // --- Cubit ---
  sl.registerFactory(
    () => ImagePickerCubit(imagePickerManager: sl<ImagePickerManager>()),
  );
}
