import 'package:chefaa/core/models/auth_response.dart';
import 'package:chefaa/presentation/patient/auth/data/repositories/patient_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error_handling/error_handler.dart';
import '../../../../../core/services/storage_service.dart';
import '../data_sources/patient_data_source.dart';

@Injectable(as: PatientRepo)
class PatientRepoImp implements PatientRepo {
  PatientDataSource patientDataSource;

  PatientRepoImp(this.patientDataSource);

  @override
  Future<AuthResponse> patientSignUp({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      var response = await patientDataSource.patientSignUp(
        name: name,
        userName: userName,
        phone: phone,
        email: email,
        password: password,
        role: role,
      );
      if (response.statusCode == 201) {
        AuthResponse data = AuthResponse.fromJson(response.data);
        await StorageService.saveToken(data.accessToken!);
        return data;
      } else {
        var error = ErrorHandler.fromJson(response.data);
        throw error.message ?? "";
      }
    } on DioException catch (e, s) {
      print(s);
      var error = ErrorHandler.fromJson(e.response?.data);
      throw error.message ?? "";
    } catch (e, s) {
      print(e);
      print(s);
      rethrow;
    }
  }
}
