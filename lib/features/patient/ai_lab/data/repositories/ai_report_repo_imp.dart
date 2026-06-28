import 'dart:convert';
import 'dart:isolate';

import 'package:chefaa/features/patient/ai_lab/data/datasources/ai_report_data_source.dart';
import 'package:chefaa/features/patient/ai_lab/data/models/report_analysis.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/ai_lab/domain/repositories/ai_report_repo.dart';

@Injectable(as: AIReportRepo)
class AiReportRepoImp implements AIReportRepo {
  AIReportDataSource aiReportDataSource;

  AiReportRepoImp(this.aiReportDataSource);

  @override
  Future<ReportAnalysis> reportAnalysis(PlatformFile? report) async {
    try {
      var response = await aiReportDataSource.reportAnalysis(report);
      final body = response.data;
      if (body is String) {
        final decoded = await Isolate.run(() => jsonDecode(body));
        return ReportAnalysis.fromJson(decoded);
      }
      return ReportAnalysis.fromJson(body);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}

