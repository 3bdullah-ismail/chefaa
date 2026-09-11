
import 'package:chefaa/core/imports/imports.dart';
abstract class DashboardRemoteSource {
  Future<Response> uploadResult({
    required String requestId,
    required String filePath,
  });

  Future<Response> getDashboard();

  Future<Response> createPatientRequest({
    required String patientPhone,
    required List<String> serviceIds,
    required bool viaAI,
  });
}
