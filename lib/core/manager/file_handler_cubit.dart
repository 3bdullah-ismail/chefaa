import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../widget/file_helper.dart';

part 'file_handler_state.dart';

class FileHandlerCubit extends Cubit<FileHandlerState> {
  FileHandlerCubit() : super(FileHandlerInitial());
  static FileHandlerCubit get(context) => BlocProvider.of(context);
  PlatformFile? pickedFile;

  Future<void> pickSingleFile() async {
    try {
      emit(FileLoading());
      final file = await FileHelper.pickSingleFile();

      if (file != null) {
        pickedFile = file;
        emit(FilePickedSuccess(file));
      } else {
        emit(FileHandlerInitial()); // رجوع للحالة الأولى لو كنسل
      }
    } catch (e) {
      emit(FileError('Failed to pick file: $e'));
    }
  }

  void clearFile() {
    pickedFile = null;
    emit(FileHandlerInitial());
  }
}
