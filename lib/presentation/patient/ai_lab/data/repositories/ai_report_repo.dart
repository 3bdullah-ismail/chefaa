import 'package:chefaa/presentation/patient/ai_lab/data/models/Report_analysis.dart';
import 'package:file_picker/file_picker.dart';

abstract class AIReportRepo {
  Future<ReportAnalysis>reportAnalysis(PlatformFile? report);
}