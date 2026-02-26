import 'package:chefaa/presentation/patient/complete_auth_data/data/data_sources/complete_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/error_handling/error_handler.dart';
import '../models/complete_patient_data_response.dart';
import 'complete_patient_repo.dart';

@Injectable(as: CompletePatientRepo)
class CompletePatientRepoImp implements CompletePatientRepo {
  CompleteDataSource completeDataSource;

  CompletePatientRepoImp({required this.completeDataSource});

  @override
  Future<CompletePatientDataResponse> completeSignUp({
    required double? weight,
    required int? height,
    required String? bloodType,
    required String? gender,
    required int? age,
    required List<String>? chronicDiseases,
    required List<String>? allergies,
  }) async {
    try {
      final response = await completeDataSource.completeSignUp(
        weight: weight,
        height: height,
        bloodType: bloodType,
        gender: gender,
        age: age,
        chronicDiseases: chronicDiseases,
        allergies: allergies,
      );

      if (response.statusCode == 200) {
        CompletePatientDataResponse patient =
            CompletePatientDataResponse.fromJson(response.data);
        return patient;
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
