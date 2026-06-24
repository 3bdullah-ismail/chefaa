import '../models/lab_results_response.dart';

abstract class LabResultsRepository {
  Future<LabResultsResponse> getLabResults();
}
