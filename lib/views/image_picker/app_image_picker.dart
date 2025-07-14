import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_adapter/image_picker_adapter.dart';
import 'package:reusable_image_widget/reusable_image_widget.dart';

class AppImagePicker extends StatelessWidget {
  const AppImagePicker({
    super.key,
    this.imageSource,
    this.imageQuality = 35,
    this.maxHeight,
    this.maxWidth,
    this.crop = false,
    this.compress = false,
    this.builder,
    this.onChanged,
    this.cameraEnabled = true,
    this.galleryEnabled = true,
    this.autoResetOnPop = true,
    this.sourceSelector = const ImageSourceSelectorService(),
    this.errorWidget,
    this.loadingWidget,
  });

  /// Fallback image path or URL
  final String? imageSource;

  /// Custom builder for picked file view
  final WidgetImageBuilder? builder;

  /// Callback when image is picked
  final ValueChanged<XFile?>? onChanged;

  /// Picker configuration
  final int imageQuality;
  final double? maxHeight;
  final double? maxWidth;
  final bool crop;
  final bool compress;

  /// Source selection configuration
  final bool cameraEnabled;
  final bool galleryEnabled;
  final IImageSourceSelectorService sourceSelector;

  /// Reset picker state when popped
  final bool autoResetOnPop;

  /// Custom UI widgets
  final Widget? errorWidget;
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    Widget content = BlocConsumer<ImagePickerCubit, ImagePickerState>(
      listenWhen: (previous, current) =>
          current is ImagePickerSuccess && current.pickedFile != null,
      listener: (context, state) {
        if (state is ImagePickerSuccess) {
          onChanged?.call(state.pickedFile);
        }
      },
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        XFile? pickedFile;
        Widget child;

        switch (state) {
          case ImagePickerLoading():
            child = _buildViewer(null, loading: loadingWidget);
            break;

          case ImagePickerSuccess():
            pickedFile = state.pickedFile;
            child = _buildViewer(pickedFile);
            break;

          case ImagePickerFailure():
            child = _buildViewer(
              null,
              error:
                  errorWidget ??
                  AppImagePickerErrorWidget(
                    message: state.message,
                    onRetry: () => _handlePick(context),
                  ),
            );
            break;

          default:
            child = _buildViewer(null);
        }

        return InkWell(onTap: () => _handlePick(context), child: child);
      },
    );

    if (autoResetOnPop) {
      content = PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) async {
          context.read<ImagePickerCubit>().clear();
        },
        child: content,
      );
    }

    return content;
  }

  void _handlePick(BuildContext context) {
    sourceSelector.selectImageSource(
      context: context,
      cameraEnabled: cameraEnabled,
      galleryEnabled: galleryEnabled,
      onSourceSelected: (source) => _pickImage(context, source),
    );
  }

  void _pickImage(BuildContext context, ImageSource source) {
    final cubit = context.read<ImagePickerCubit>();
    cubit.onPickImage(
      context: context,
      mounted: () => context.mounted,
      source: source,
      crop: crop,
      compress: compress,
      quality: imageQuality,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );
  }

  Widget _buildViewer(XFile? pickedFile, {Widget? error, Widget? loading}) {
    return builder?.call(pickedFile) ??
        AppImageViewer(
          pickedFile: pickedFile,
          imageSource: imageSource,
          errorWidget: error,
          placeholder: loading,
        );
  }
}
