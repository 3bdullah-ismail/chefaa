import 'package:chefaa/presentation/patient/auth/data/data_sources/patient_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network_service.dart';

@Injectable(as: PatientDataSource)
class PatientDataSourceImp implements PatientDataSource {
  NetworkService networkService;

  PatientDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> patientSignUp({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
  }) {
    return networkService.dio.post(
      "/auth/register",
      data: {
        "name": name,
        "username": userName,
        "email": email,
        "password": password,
        "phoneNumber": phone,
        "role": role,
      },
      options: Options(headers: {"Content-Type": "application/json"}),
    );
  }
}
