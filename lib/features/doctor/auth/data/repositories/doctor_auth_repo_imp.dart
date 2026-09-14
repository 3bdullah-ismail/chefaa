import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/services/storage_service.dart';
import 'package:chefaa/features/auth/data/models/auth_response.dart';
import 'package:chefaa/features/doctor/auth/data/data_sources/doctor_auth_data_source.dart';
import 'package:chefaa/features/doctor/auth/data/repositories/doctor_auth_repo.dart';

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
      throw 'An unexpected error occurred. Please try again.';
    }
  }
}
