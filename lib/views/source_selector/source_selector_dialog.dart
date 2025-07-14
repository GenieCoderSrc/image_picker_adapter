import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SourceSelectorDialog extends StatelessWidget {
  const SourceSelectorDialog({super.key, required this.onSelected});

  final void Function(ImageSource source) onSelected;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Source'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onSelected(ImageSource.camera);
          },
          child: const Text('Camera'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onSelected(ImageSource.gallery);
          },
          child: const Text('Gallery'),
        ),
      ],
    );
  }
}
