import 'package:chefaa/core/services/network_service.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'data_source.dart';

@Injectable(as: DoctorAuthDataSource)
class DoctorAuthDataSourceImp implements DoctorAuthDataSource {
  NetworkService networkService;
  DoctorAuthDataSourceImp(this.networkService);
  @override
  Future<Response> signUp({
    required String name,
    required String email,
    required String username,
    required String password,
    required String phoneNumber,
    required String specialization,
    required PlatformFile membership,
  }) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "email": email,
      "username": username,
      "password": password,
      "role": 'doctor',
      "phoneNumber": phoneNumber,
      "specialization": specialization,
      "membership": await MultipartFile.fromFile(
        membership.path!,
        filename: membership.name,
      ),
    });
    return networkService.dio.post("/auth/register", data: formData);
  }
}
