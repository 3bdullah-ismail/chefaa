import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chefaa/core/widgets/file_helper.dart';

part 'file_handler_state.dart';

class FileHandlerCubit extends Cubit<FileHandlerState> {
  FileHandlerCubit() : super(FileHandlerInitial());

  static FileHandlerCubit get(BuildContext context) => BlocProvider.of(context);
  PlatformFile? pickedFile;

  Future<void> pickSingleFile() async {
    try {
      if (!isClosed) emit(FileLoading());
      final file = await FileHelper.pickSingleFile();

      if (file != null) {
        pickedFile = file;
      if (!isClosed) emit(FilePickedSuccess(file));
      } else {
      if (!isClosed) emit(FileHandlerInitial());
      }
    } catch (e) {
      if (!isClosed) emit(FileError('Failed to pick file: $e'));
    }
  }

  void clearFile() {
    pickedFile = null;
      if (!isClosed) emit(FileHandlerInitial());
  }
}
