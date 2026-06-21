import 'dart:convert';
import 'dart:isolate';

import 'package:chefaa/core/models/auth_response.dart';
import 'package:chefaa/presentation/patient/auth/data/repositories/patient_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error_handling/failure.dart';
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
      dynamic body = response.data;
      AuthResponse data;
      if (body is String) {
        final decoded = await Isolate.run(() => jsonDecode(body));
        data = AuthResponse.fromJson(decoded);
      } else {
        data = AuthResponse.fromJson(body);
      }
      if (data.accessToken != null) {
        await StorageService.saveToken(data.accessToken!);
      }
      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}
