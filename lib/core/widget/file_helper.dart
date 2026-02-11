import 'package:file_picker/file_picker.dart';

class FileHelper {
  /// Pick single file and return it directly
  static Future<PlatformFile?> pickSingleFile({
    List<String> allowedExtensions = const ['jpg', 'png', 'jpeg', 'pdf'],
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files.first;
    }

    return null;
  }

  /// format file size
  static String formatFileSize(int bytes) {
    final kb = bytes / 1024;

    if (kb < 1024) {
      return "${kb.toStringAsFixed(0)} KB";
    }

    final mb = kb / 1024;
    return "${mb.toStringAsFixed(2)} MB";
  }
}
