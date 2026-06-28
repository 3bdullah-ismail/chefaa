import 'dart:convert';
import 'dart:isolate';

import 'package:chefaa/features/auth/data/models/auth_response.dart';
import 'package:chefaa/features/facility/auth/data/data_sources/facility_auth_source.dart';
import 'package:chefaa/features/facility/auth/domain/repositories/facility_auth_repo.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/core/services/storage_service.dart';

@Injectable(as: FacilityAuthRepo)
class FacilityAuthRepoImpl implements FacilityAuthRepo {
  final FacilityAuthDataSource facilityAuthDataSource;

  FacilityAuthRepoImpl(this.facilityAuthDataSource);

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

