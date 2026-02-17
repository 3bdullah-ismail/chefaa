import 'package:chefaa/presentation/pharmacy/auth/data/repositories/pharmacy_repo.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error_handling/error_handler.dart';
import '../../../../../core/services/storage_service.dart';
import '../data_sources/pharmacy_data_source.dart';
import '../models/PharmacyModel.dart';

@Injectable(as: PharmacyRepo)
class PharmacyRepoImp implements PharmacyRepo {
  PharmacyDataSource pharmacyDataSource;

  PharmacyRepoImp({required this.pharmacyDataSource});

  @override
  Future<PharmacyModel> pharmacySignUp({
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
      if (response.statusCode == 201) {
        PharmacyModel data = PharmacyModel.fromJson(response.data);
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
