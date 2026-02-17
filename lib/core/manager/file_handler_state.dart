part of 'file_handler_cubit.dart';

@immutable
sealed class FileHandlerState {}

class FileHandlerInitial extends FileHandlerState {}

class FileLoading extends FileHandlerState {}

class FilePickedSuccess extends FileHandlerState {
  final PlatformFile file;

  FilePickedSuccess(this.file);
}

class FileError extends FileHandlerState {
  final String message;

  FileError(this.message);
}
