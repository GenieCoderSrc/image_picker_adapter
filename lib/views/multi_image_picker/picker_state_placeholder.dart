import 'package:flutter/material.dart';
import 'package:image_picker_adapter/view_models/image_picker_cubit/image_picker_cubit.dart';

class PickerStatePlaceholder extends StatelessWidget {
  const PickerStatePlaceholder({
    super.key,
    required this.pickerState,
    required this.isLoading,
    required this.defaultText,
    required this.pickerIcon,
    this.defaultTextStyle,
    this.loadingWidget,
    this.errorWidget,
  });

  final ImagePickerState pickerState;
  final bool isLoading;
  final String defaultText;
  final Widget pickerIcon;
  final TextStyle? defaultTextStyle;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isLoading) {
      return loadingWidget ??
          _BasePlaceholderCard(
            cardColor: Colors.grey[200],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(height: 8),
                Text(
                  'Processing...',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          );
    }

    if (pickerState is ImagePickerFailure) {
      final message = (pickerState as ImagePickerFailure).message;
      return errorWidget ??
          _BasePlaceholderCard(
            cardColor: theme.colorScheme.errorContainer,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Icon(
                  Icons.error_outline,
                  color: theme.colorScheme.error,
                  size: 32,
                ),
                Text(
                  'Error: $message',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
    }

    return _BasePlaceholderCard(
      cardColor: theme.cardTheme.color,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          pickerIcon,
          const SizedBox(height: 8),
          Text(defaultText, style: defaultTextStyle),
        ],
      ),
    );
  }
}

/// A private internal layout primitive to keep custom styles completely DRY.
class _BasePlaceholderCard extends StatelessWidget {
  const _BasePlaceholderCard({required this.child, this.cardColor});

  final Widget child;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
          child: child,
        ),
      ),
    );
  }
}
