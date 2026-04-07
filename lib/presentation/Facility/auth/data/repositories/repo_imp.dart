import 'package:chefaa/core/models/auth_response.dart';
import 'package:chefaa/presentation/Facility/auth/data/data_sources/data_source.dart';
import 'package:chefaa/presentation/Facility/auth/data/repositories/repo.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/error_handling/failure.dart';
import '../../../../../core/services/storage_service.dart';

@Injectable(as: FacilityAuthRepo)
class FacilityRepoImp implements FacilityAuthRepo {
  FacilityAuthDataSource facilityAuthDataSource;

  FacilityRepoImp(this.facilityAuthDataSource);

  @override
  Future<AuthResponse> signUP({
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
    try {
      var response = await facilityAuthDataSource.signUP(
        name: name,
        username: username,
        email: email,
        password: password,
        commercialRegisterNumber: commercialRegisterNumber,
        facilityType: facilityType,
        medicalDirectorName: medicalDirectorName,
        directorProfessionalId: directorProfessionalId,
        phoneNumber: phoneNumber,
        medicalLicence: medicalLicence,
      );
      AuthResponse data = AuthResponse.fromJson(response.data);
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
