import 'package:chefaa/core/imports/imports.dart';

abstract class AIReportDataSource {
  Future<Response> reportAnalysis(PlatformFile? report);
}
