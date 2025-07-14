import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_adapter/enums/source_selector_style.dart';
import 'package:image_picker_adapter/views/source_selector/image_source_selector.dart';
import 'package:image_picker_adapter/views/source_selector/source_selector_dialog.dart';

void presentSourceSelectorUI({
  required BuildContext context,
  required void Function(ImageSource source) onSelected,
  required SourceSelectorStyle style,
  Widget? customSelector,
}) {
  switch (style) {
    case SourceSelectorStyle.alertDialog:
      _showAlertDialog(context, onSelected, customSelector);
      break;

    case SourceSelectorStyle.bottomSheet:
      _showBottomSheet(context, onSelected, customSelector);
      break;

    case SourceSelectorStyle.custom:
      _showCustomSelector(context, customSelector);
      break;

    default:
      throw UnimplementedError('Unsupported SourceSelectorStyle: $style');
  }
}

void _showAlertDialog(
  BuildContext context,
  void Function(ImageSource) onSelected,
  Widget? customSelector,
) {
  showDialog(
    context: context,
    builder: (_) =>
        customSelector ?? SourceSelectorDialog(onSelected: onSelected),
  );
}

void _showBottomSheet(
  BuildContext context,
  void Function(ImageSource) onSelected,
  Widget? customSelector,
) {
  showModalBottomSheet(
    context: context,
    builder: (_) =>
        customSelector ??
        ImageSourceSelector(
          onTap: (source) {
            Navigator.pop(context);
            onSelected(source);
          },
        ),
  );
}

void _showCustomSelector(BuildContext context, Widget? customSelector) {
  if (customSelector != null) {
    showDialog(context: context, builder: (_) => customSelector);
  }
}
