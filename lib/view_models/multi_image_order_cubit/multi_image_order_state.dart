part of 'multi_image_order_cubit.dart';

class MultiImageOrderState extends Equatable {
  final List<XFile> selectedFiles;

  const MultiImageOrderState({this.selectedFiles = const []});

  @override
  List<Object?> get props => [selectedFiles];
}
