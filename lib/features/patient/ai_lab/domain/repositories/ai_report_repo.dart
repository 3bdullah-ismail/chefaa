import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/features/patient/ai_lab/data/models/report_analysis.dart';

abstract class AIReportRepo {
  Future<ReportAnalysis> reportAnalysis(PlatformFile? report);
}

