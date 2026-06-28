import 'package:chefaa/features/patient/lab_results/data/models/lab_results_response.dart';

abstract class LabResultsRepository {
  Future<LabResultsResponse> getLabResults();
}
