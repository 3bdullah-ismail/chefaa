import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

abstract class AIReportDataSource {
  Future<Response> reportAnalysis(PlatformFile? report);
}
