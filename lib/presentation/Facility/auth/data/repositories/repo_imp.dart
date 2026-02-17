import 'package:chefaa/core/models/auth_response.dart';
import 'package:chefaa/presentation/Facility/auth/data/data_sources/data_source.dart';
import 'package:chefaa/presentation/Facility/auth/data/repositories/repo.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error_handling/error_handler.dart';
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
