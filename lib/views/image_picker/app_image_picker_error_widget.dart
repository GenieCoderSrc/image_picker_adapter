import 'package:flutter/material.dart';

class AppImagePickerErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const AppImagePickerErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 40),
        Text(message, style: const TextStyle(color: Colors.red)),
        ElevatedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text('Retry'),
        ),
      ],
    );
  }
}
