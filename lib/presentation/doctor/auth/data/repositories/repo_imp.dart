import 'package:chefaa/presentation/doctor/auth/data/data_sources/data_source.dart';
import 'package:chefaa/presentation/doctor/auth/data/repositories/repo.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/error_handling/error_handler.dart';
import '../../../../../core/services/storage_service.dart';
import '../../../../../core/models/auth_response.dart';

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
