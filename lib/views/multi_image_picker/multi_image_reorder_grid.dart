// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_adapter/view_models/multi_image_order_cubit/multi_image_order_cubit.dart';
import 'package:reusable_image_widget/views/widgets/image_viewer/app_image_viewer.dart';

class MultiImageReorderGridView extends StatelessWidget {
  const MultiImageReorderGridView({
    super.key,
    required this.files,
    required this.isLoading,
    this.crossAxisCount = 3,
    this.crossAxisSpacing = 8.0,
    this.mainAxisSpacing = 8.0,
    required this.onTapAdd,
    this.onChanged,
  });

  final List<XFile> files;
  final bool isLoading;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final VoidCallback onTapAdd;
  final void Function(List<XFile> files)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ReorderableBuilder(
      lockedIndices: [files.length],
      children: [
        ...files.asMap().entries.map((entry) {
          final index = entry.key;
          final file = entry.value;

          return Stack(
            key: ValueKey(file.path),
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  // Leverages the package to auto-detect XFile / Network / Asset fields
                  // safely on Web, iOS, Android, and Desktop environments
                  child: AppImageViewer(
                    pickedFile: file,
                    imageSource: file.path,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () {
                    context.read<MultiImageOrderCubit>().removeFile(index);
                    onChanged?.call(
                      context.read<MultiImageOrderCubit>().state.selectedFiles,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
        GestureDetector(
          key: const ValueKey('grid_incremental_add_button'),
          onTap: isLoading ? null : onTapAdd,
          child: Container(
            decoration: BoxDecoration(
              color: isLoading
                  ? Colors.grey[200]
                  : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.add, size: 24),
            ),
          ),
        ),
      ],
      onReorder: (ReorderedListFunction reorderedListFunction) {
        final imagesOnly = List<XFile>.from(files);
        final reorderedList = reorderedListFunction(imagesOnly) as List<XFile>;

        context.read<MultiImageOrderCubit>().updateFiles(reorderedList);
        onChanged?.call(reorderedList);
      },
      builder: (children) {
        return GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
          ),
          children: children,
        );
      },
    );
  }
}
