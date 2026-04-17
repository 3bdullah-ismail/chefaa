import 'package:file_picker/file_picker.dart';

class FileHelper {
  /// Pick single file and return it directly
  static Future<PlatformFile?> pickSingleFile({
    List<String> allowedExtensions = const ['jpg', 'png', 'jpeg', 'pdf'],
  }) async {
    // In newer versions of file_picker, pickFiles is called directly on FilePicker
    final result = await FilePicker.pickFiles(
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
    if (bytes <= 0) return '0 KB';

    const kb = 1024;
    const mb = kb * 1024;

    if (bytes < kb) {
      return '$bytes B';
    } else if (bytes < mb) {
      final kbValue = bytes / kb;
      return "${kbValue.toStringAsFixed(0)} KB";
    } else {
      final mbValue = bytes / mb;
      return "${mbValue.toStringAsFixed(2)} MB";
    }
  }
}
