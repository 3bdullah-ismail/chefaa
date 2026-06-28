import 'dart:convert';
import 'dart:isolate';
import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/pharmacy/settings/data/data_sources/pharmacy_settings_data_source.dart';
import 'package:chefaa/features/pharmacy/settings/data/models/pharmacy_status_response.dart';
import 'package:chefaa/features/pharmacy/settings/domain/repositories/pharmacy_settings_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PharmacySettingsRepo)
class PharmacySettingsRepoImpl implements PharmacySettingsRepo {
  final PharmacySettingsDataSource pharmacySettingsDataSource;

  PharmacySettingsRepoImpl({required this.pharmacySettingsDataSource});

  @override
  Future<PharmacyStatusResponse> updateStatus(Map<String, dynamic> body) async {
    try {
      final response = await pharmacySettingsDataSource.updateStatus(body);
      final responseBody = response.data;
      PharmacyStatusResponse data;
      if (responseBody is String) {
        final decoded = await Isolate.run(() => jsonDecode(responseBody));
        data = PharmacyStatusResponse.fromJson(
          decoded as Map<String, dynamic>,
        );
      } else {
        data = PharmacyStatusResponse.fromJson(
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
