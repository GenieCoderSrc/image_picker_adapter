# 📦 image_picker_adapter

A highly customizable, cross-platform image picking, cropping, and compression toolkit built on top of Flutter's `image_picker`, `image_cropper`, and `flutter_image_compress`. This adapter provides a modular, testable, and UI-agnostic solution for seamless image selection and preprocessing in your apps.

---

## 🚀 Features

* ✅ Platform-aware image selection from camera or gallery
* 🖼️ Multi-image picking with reordering support
* ✂️ Optional image cropping (with customizable UI)
* 🗜️ Optional image compression
* 🧩 Modular architecture (SOLID principles)
* 🔄 Supports Cubit for state-driven image picking
* 🖼️ Custom UI builders for both avatar and image pickers
* 📦 Easy to plug into any Flutter app via DI and `BlocProvider`

---

## 📦 Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  image_picker_adapter: latest_version
```

Then run:

```bash
flutter pub get
```

---

## 🧱 Architecture Overview

```
┌──────────────────────────┐
│    AppImagePicker        │ ◄── Customizable Widget
├──────────────────────────┤
│  ↳ ImagePickerCubit      │ ◄── Handles image picking states
│  ↳ ImagePickerManager    │ ◄── Coordinates services
│     ↳ AppImagePickerService
│     ↳ IImageCropperService
│     ↳ IImageCompressorService
└──────────────────────────┘

┌──────────────────────────┐
│    MultiImagePicker      │ ◄── Multiple images selection
├──────────────────────────┤
│  ↳ MultiImageOrderCubit  │ ◄── Handles ordering & selection
│  ↳ ImagePickerCubit      │ ◄── Underlying picking logic
└──────────────────────────┘
```

---

## 🛠️ Getting Started

### 1. ✅ Register Dependencies

```dart
void registerImagePickerAdapterDependencies() {
  sl.registerLazySingleton<AppImagePickerService>(() => AppImagePickerService());
  sl.registerLazySingleton<IImageCropperService>(() => AppImageCropperService());
  sl.registerLazySingleton<IImageCompressorService>(() => AppImageCompressorService());

  sl.registerLazySingleton<ImagePickerManager>(
    () => ImagePickerManager(
      pickerService: sl<AppImagePickerService>(),
      cropperService: sl<IImageCropperService>(),
      compressorService: sl<IImageCompressorService>(),
    ),
  );

  sl.registerFactory(
    () => ImagePickerCubit(imagePickerManager: sl<ImagePickerManager>()),
  );

  sl.registerFactory(
    () => MultiImageOrderCubit(),
  );
}
```

### 2. 🧠 Provide Bloc

```dart
List<SingleChildWidget> imagePickerAdapterBlocProviders = [
  BlocProvider<ImagePickerCubit>(create: (_) => sl<ImagePickerCubit>()),
  BlocProvider<MultiImageOrderCubit>(create: (_) => sl<MultiImageOrderCubit>()),
];
```

### 3. 🎨 Use `AppImagePicker` Widget

```dart
AppImagePicker(
  imageQuality: 80,
  crop: true,
  compress: true,
  onChanged: (file) {
    // Do something with XFile
  },
  builder: (file) => CircleAvatar(
    backgroundImage: file != null ? FileImage(File(file.path)) : null,
  ),
)
```

### 4. 🖼️ Use `MultiImagePicker` Widget

To pick and manage multiple images, use the `MultiImagePicker` along with `MultiImageOrderCubit` for selection and ordering.

```dart
MultiImagePicker(
  onChanged: (files) {
    // 'files' is a List<XFile> of selected images
    debugPrint('Selected ${files.length} images');
  },
  imageQuality: 85,
  crop: false,
  compress: true,
  crossAxisCount: 3,
  crossAxisSpacing: 8.0,
  mainAxisSpacing: 8.0,
)
```


---

## 👤 Avatar Picker Example

```dart
AvatarImagePicker(
  imageSource: user.avatarUrl,
  radius: 40,
  crop: true,
  compress: true,
  onChanged: (file) => print('Picked: ${file?.path}'),
)
```

---

## 🧪 Extension Utilities

```dart
extension XFileParserExtension on XFile {
  Future<T?> parseAs<T>() async {
    if (T == File) return File(path) as T;
    if (T == Uint8List) return await readAsBytes() as T;
    if (T == String) return path as T;
    if (T == XFile) return this as T;
    throw UnsupportedError('Unsupported type conversion: $T');
  }
}
```

---

## 🧭 Source Selector Modes

* `bottomSheet` (default)
* `alertDialog`
* `custom`

You can inject your own selector widget or use built-in ones like `SourceSelectorDialog` or `ImageSourceSelector`.

---

## 🧩 Customization

* Build your own image viewer UI with `builder` in `AppImagePicker`
* Customize source selection UI via `IImageSourceSelectorService`
* Provide your own crop/compress service by implementing `IImageCropperService`, `IImageCompressorService`

---

## 📄 License

MIT License

---

## 🙌 Contributions

Feel free to open issues, pull requests or contribute ideas to enhance the `image_picker_adapter`.

---

## 🧠 Credits

* [image_picker](https://pub.dev/packages/image_picker)
* [image_cropper](https://pub.dev/packages/image_cropper)
* [flutter_image_compress](https://pub.dev/packages/flutter_image_compress)
* Inspired by real-world production usage in Flutter apps

---

## 👨‍💼 Author

**image_picker_adapter**
Developed with ❤️ by [Shohidul Islam](https://github.com/ShohidulProgrammer)

