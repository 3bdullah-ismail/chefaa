import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/core/services/network_service.dart';
import 'ai_report_data_source.dart';

@Injectable(as: AIReportDataSource)
class AIReportDataSourceImp implements AIReportDataSource {
  final NetworkService networkService;

  AIReportDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> reportAnalysis(PlatformFile? report) async {
    FormData formData = FormData.fromMap({
      "labReport": await MultipartFile.fromFile(
        report!.path!,
        filename: report.name,
      ),
    });

    final response = await networkService.dio.post(
      "/labReport/analyze",
      data: formData,
    );

    return response;
  }
}
