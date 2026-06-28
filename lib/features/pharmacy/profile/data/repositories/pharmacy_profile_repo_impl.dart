import 'dart:convert';
import 'dart:isolate';
import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/pharmacy/profile/data/data_sources/pharmacy_profile_data_source.dart';
import 'package:chefaa/features/pharmacy/profile/data/models/pharmacy_profile_response.dart';
import 'package:chefaa/features/pharmacy/profile/domain/repositories/pharmacy_profile_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PharmacyProfileRepo)
class PharmacyProfileRepoImpl implements PharmacyProfileRepo {
  final PharmacyProfileDataSource pharmacyProfileDataSource;

  PharmacyProfileRepoImpl({required this.pharmacyProfileDataSource});

  @override
  Future<PharmacyProfileResponse> getPharmacyProfile() async {
    try {
      final response = await pharmacyProfileDataSource.getPharmacyProfile();
      final body = response.data;
      PharmacyProfileResponse data;
      if (body is String) {
        final decoded = await Isolate.run(() => jsonDecode(body));
        data = PharmacyProfileResponse.fromJson(
          decoded as Map<String, dynamic>,
        );
      } else {
        data = PharmacyProfileResponse.fromJson(body as Map<String, dynamic>);
      }
      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<PharmacyProfileResponse> updatePharmacyProfile(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await pharmacyProfileDataSource.updatePharmacyProfile(
        body,
      );
      final responseBody = response.data;
      PharmacyProfileResponse data;
      if (responseBody is String) {
        final decoded = await Isolate.run(() => jsonDecode(responseBody));
        data = PharmacyProfileResponse.fromJson(
          decoded as Map<String, dynamic>,
        );
      } else {
        data = PharmacyProfileResponse.fromJson(
          responseBody as Map<String, dynamic>,
        );
      }
      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}
