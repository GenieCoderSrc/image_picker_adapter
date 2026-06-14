import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_adapter/typedefs/typedefs.dart';
import 'package:image_picker_adapter/view_models/image_picker_cubit/image_picker_cubit.dart';
import 'package:image_picker_adapter/view_models/multi_image_order_cubit/multi_image_order_cubit.dart';

import 'picker_state_placeholder.dart';
import 'multi_image_reorder_grid.dart';

class MultiImagePicker extends StatelessWidget {
  const MultiImagePicker({
    super.key,
    this.onChanged,
    this.imageQuality = 85,
    this.crop = false,
    this.compress = true,
    this.builder,
    this.loadingWidget,
    this.errorWidget,
    this.defaultText = 'Add Images',
    this.defaultTextStyle,
    this.pickerIcon = const Icon(Icons.add_photo_alternate_outlined, size: 28),
    this.crossAxisCount = 3,
    this.crossAxisSpacing = 8.0,
    this.mainAxisSpacing = 8.0,
  });

  final void Function(List<XFile> files)? onChanged;
  final int imageQuality;
  final bool crop;
  final bool compress;
  final WidgetMultiImageBuilder? builder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final String defaultText;
  final TextStyle? defaultTextStyle;
  final Widget pickerIcon;

  // Grid configs passed down to the Grid Component
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerCubit, ImagePickerState>(
      listenWhen: (previous, current) =>
          current is ImagePickerMultiSuccess || current is ImagePickerFailure,
      listener: (context, state) {
        if (state is ImagePickerMultiSuccess) {
          context.read<MultiImageOrderCubit>().appendFiles(state.pickedFiles);
          onChanged?.call(
            context.read<MultiImageOrderCubit>().state.selectedFiles,
          );
        } else if (state is ImagePickerFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, pickerState) {
        final isLoading = pickerState is ImagePickerLoading;
        final currentFiles = context
            .watch<MultiImageOrderCubit>()
            .state
            .selectedFiles;

        // Custom builder override branch
        if (builder != null) {
          return GestureDetector(
            onTap: isLoading ? null : () => _triggerImagePicker(context),
            child: builder!.call(context, currentFiles, isLoading: isLoading),
          );
        }

        // Conditional Layout Strategy (SRP)
        if (currentFiles.isNotEmpty) {
          return MultiImageReorderGridView(
            files: currentFiles,
            isLoading: isLoading,
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            onTapAdd: () => _triggerImagePicker(context),
            onChanged: onChanged,
          );
        }

        return GestureDetector(
          onTap: isLoading ? null : () => _triggerImagePicker(context),
          child: PickerStatePlaceholder(
            pickerState: pickerState,
            isLoading: isLoading,
            defaultText: defaultText,
            defaultTextStyle: defaultTextStyle,
            pickerIcon: pickerIcon,
            loadingWidget: loadingWidget,
            errorWidget: errorWidget,
          ),
        );
      },
    );
  }

  void _triggerImagePicker(BuildContext context) {
    context.read<ImagePickerCubit>().onPickMultiImages(
      context: context,
      mounted: () => context.mounted,
      crop: crop,
      compress: compress,
      quality: imageQuality,
    );
  }
}
