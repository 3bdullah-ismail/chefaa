import 'dart:convert';
import 'dart:isolate';
import 'package:chefaa/core/models/auth_response.dart';
import 'package:chefaa/presentation/pharmacy/auth/data/repositories/pharmacy_repo.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/error_handling/failure.dart';
import '../../../../../core/services/storage_service.dart';
import '../data_sources/pharmacy_data_source.dart';

@Injectable(as: PharmacyRepo)
class PharmacyRepoImp implements PharmacyRepo {
  PharmacyDataSource pharmacyDataSource;

  PharmacyRepoImp({required this.pharmacyDataSource});

  @override
  Future<AuthResponse> pharmacySignUp({
    required String name,
    required String username,
    required String phoneNumber,
    required String email,
    required String role,
    required String password,
    required PlatformFile medicalLicence,
    required String commercialRegisterNumber,
  }) async {
    var response = await pharmacyDataSource.pharmacySignUp(
      name: name,
      username: username,
      phoneNumber: phoneNumber,
      email: email,
      role: role,
      password: password,
      medicalLicence: medicalLicence,
      commercialRegisterNumber: commercialRegisterNumber,
    );
    try {
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
