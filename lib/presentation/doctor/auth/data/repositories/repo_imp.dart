import 'dart:convert';
import 'dart:isolate';

import 'package:chefaa/presentation/doctor/auth/data/data_sources/data_source.dart';
import 'package:chefaa/presentation/doctor/auth/data/repositories/repo.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error_handling/failure.dart';
import '../../../../../core/models/auth_response.dart';
import '../../../../../core/services/storage_service.dart';

@Injectable(as: DoctorAuthRepo)
class DoctorAuthRepoImp extends DoctorAuthRepo {
  DoctorAuthDataSource doctorAuthDataSource;

  DoctorAuthRepoImp(this.doctorAuthDataSource);

  @override
  Future<AuthResponse> signUp({
    required String name,
    required String email,
    required String username,
    required String password,
    required String phoneNumber,
    required String specialization,
    required PlatformFile membership,
  }) async {
    try {
      var response = await doctorAuthDataSource.signUp(
        name: name,
        email: email,
        password: password,
        username: username,
        phoneNumber: phoneNumber,
        specialization: specialization,
        membership: membership,
      );
      final body = response.data;
      final AuthResponse data = body is String
          ? AuthResponse.fromJson(await Isolate.run(() => jsonDecode(body)))
          : AuthResponse.fromJson(body);
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
