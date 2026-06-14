import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'multi_image_order_state.dart';

class MultiImageOrderCubit extends Cubit<MultiImageOrderState> {
  MultiImageOrderCubit() : super(const MultiImageOrderState());

  /// Updates the entire list of selected files (e.g. after a new pick)
  void updateFiles(List<XFile> newFiles) {
    emit(MultiImageOrderState(selectedFiles: newFiles));
  }

  /// Appends new files to the existing selection
  void appendFiles(List<XFile> addedFiles) {
    final updatedList = List<XFile>.from(state.selectedFiles)..addAll(addedFiles);
    emit(MultiImageOrderState(selectedFiles: updatedList));
  }

  /// Reorders the images in the list
  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < 0 || newIndex < 0 || 
        oldIndex >= state.selectedFiles.length || 
        newIndex >= state.selectedFiles.length) return;

    final List<XFile> list = List.from(state.selectedFiles);
    final XFile item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    
    emit(MultiImageOrderState(selectedFiles: list));
  }

  /// Removes a specific image from the selection
  void removeFile(int index) {
    if (index < 0 || index >= state.selectedFiles.length) return;
    
    final List<XFile> list = List.from(state.selectedFiles)..removeAt(index);
    emit(MultiImageOrderState(selectedFiles: list));
  }

  void clear() {
    emit(const MultiImageOrderState());
  }
}
