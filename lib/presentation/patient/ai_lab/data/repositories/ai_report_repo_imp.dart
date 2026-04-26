import 'package:chefaa/presentation/patient/ai_lab/data/datasources/ai_report_data_source.dart';
import 'package:chefaa/presentation/patient/ai_lab/data/models/Report_analysis.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error_handling/failure.dart';
import 'ai_report_repo.dart';

@Injectable(as: AIReportRepo)
class AiReportRepoImp implements AIReportRepo {
  AIReportDataSource aiReportDataSource;

  AiReportRepoImp(this.aiReportDataSource);

  @override
  Future<ReportAnalysis> reportAnalysis(PlatformFile? report) async {
    try {
      var response = await aiReportDataSource.reportAnalysis(report);
      return ReportAnalysis.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}
