import 'package:chefaa/features/facility/dashboard/data/models/get_dashboard_response.dart';
import 'package:chefaa/features/facility/dashboard/data/models/upload_result_response.dart';
import 'package:chefaa/features/facility/dashboard/data/models/create_patient_request_response.dart';

abstract class DashboardRepository {
  Future<UploadResultResponse> uploadResult({
    required String requestId,
    required String filePath,
  });

  Future<GetDashboardResponse> getDashboard();

  Future<CreatePatientRequestResponse> createPatientRequest({
    required String patientPhone,
    required List<String> serviceIds,
    required bool viaAI,
  });
}

