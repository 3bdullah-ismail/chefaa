import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class FileHelper {
  static Future<PlatformFile?> pickSingleFile({
    List<String> allowedExtensions = const ['jpg', 'png', 'jpeg', 'pdf'],
  }) async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.any,
        allowMultiple: false,
        withData: true,
      );
      final file = _firstPickedFile(result);
      if (file != null && _hasAllowedExtension(file.name, allowedExtensions)) {
        return file;
      }
    } catch (e) {
      debugPrint("Error picking file: $e");
    }

    return null;
  }


  static PlatformFile? _firstPickedFile(FilePickerResult? result) {
    if (result == null || result.files.isEmpty) return null;
    return result.files.first;
  }

  static bool _hasAllowedExtension(String fileName, List<String> allowed) {
    final parts = fileName.toLowerCase().split('.');
    if (parts.length < 2) return false;
    final extension = parts.last;
    return allowed.map((e) => e.toLowerCase()).contains(extension);
  }

  static String formatFileSize(int bytes) {
    if (bytes <= 0) return '0 KB';
    const kb = 1024;
    const mb = kb * 1024;

    if (bytes < kb) {
      return '$bytes B';
    } else if (bytes < mb) {
      return "${(bytes / kb).toStringAsFixed(0)} KB";
    } else {
      return "${(bytes / mb).toStringAsFixed(2)} MB";
    }
  }
}
