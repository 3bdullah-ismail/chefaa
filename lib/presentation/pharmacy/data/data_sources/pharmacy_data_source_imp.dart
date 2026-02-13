import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/presentation/pharmacy/data/data_sources/pharmacy_data_source.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PharmacyDataSource)
class PharmacyDataSourceImp implements PharmacyDataSource {
  NetworkService networkService;

  PharmacyDataSourceImp({required this.networkService});

  @override
  Future<Response> pharmacySignUp({
    required String name,
    required String username,
    required String phoneNumber,
    required String email,
    required String role,
    required String password,
    required PlatformFile medicalLicence,
    required String commercialRegisterNumber,
  }) async {
    var formData = FormData.fromMap({
      'name': name,
      'username': username,
      'phoneNumber': phoneNumber,
      'email': email,
      'role': role,
      'password': password,
      'medicalLicence': await MultipartFile.fromFile(
        medicalLicence.path!,
        filename: medicalLicence.name,
      ),
      'commercialRegisterNumber': commercialRegisterNumber,
    });
    return networkService.dio.post(
      "/auth/register",
      data: formData,
      options: Options(
        contentType: "multipart/form-data"
      ),
    );
  }
}
