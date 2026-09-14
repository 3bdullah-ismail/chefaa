import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/features/facility/auth/data/data_sources/facility_auth_source.dart';

import 'package:chefaa/core/services/network_service.dart';

@Injectable(as: FacilityAuthDataSource)
class FacilityAuthDataSourceImpl extends FacilityAuthDataSource {
  NetworkService networkService;

  FacilityAuthDataSourceImpl(this.networkService);

  @override
  Future<Response> signUP({
    required String name,
    required String username,
    required String email,
    required String password,
    required String commercialRegisterNumber,
    required String facilityType,
    required String medicalDirectorName,
    required String directorProfessionalId,
    required String phoneNumber,
    required PlatformFile medicalLicence,
  }) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "username": username,
      "email": email,
      "password": password,
      "role": "lab",
      "commercialRegisterNumber": commercialRegisterNumber,
      "facilityType": facilityType,
      "medicalDirectorName": medicalDirectorName,
      "directorProfessionalId": directorProfessionalId,
      "phoneNumber": phoneNumber,
      "medicalLicence": await MultipartFile.fromFile(
        medicalLicence.path!,
        filename: medicalLicence.name,
      ),
    });
    return networkService.dio.post(
      "/auth/register",
      data: formData,
      options: Options(
        contentType: Headers.multipartFormDataContentType,
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
  }
}
