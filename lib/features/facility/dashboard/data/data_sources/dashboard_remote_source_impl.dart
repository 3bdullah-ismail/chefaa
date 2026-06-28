import 'package:chefaa/core/services/network_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'dashboard_remote_source.dart';

@Injectable(as: DashboardRemoteSource)
class DashboardRemoteSourceImpl extends DashboardRemoteSource {
  final NetworkService _networkService;

  DashboardRemoteSourceImpl(this._networkService);

  @override
  Future<Response> uploadResult({
    required String requestId,
    required String filePath,
  }) async {
    final filename = filePath.split('/').last.split('\\').last;
    final formData = FormData.fromMap({
      "requestId": requestId,
      "resultFileUrl": await MultipartFile.fromFile(
        filePath,
        filename: filename,
      ),
    });

    return _networkService.dio.post(
      "/lab/upload-result",
      data: formData,
      options: Options(contentType: Headers.multipartFormDataContentType),
    );
  }

  @override
  Future<Response> getDashboard() async {
    return _networkService.dio.get("/lab/dashboard");
  }

  @override
  Future<Response> createPatientRequest({
    required String patientPhone,
    required List<String> serviceIds,
    required bool viaAI,
  }) async {
    return _networkService.dio.post(
      "/lab/add-request",
      data: {
        "patientPhone": patientPhone,
        "serviceIds": serviceIds,
        "viaAI": viaAI,
      },
    );
  }
}
