import 'package:chefaa/presentation/patient/complete_auth_data/data/data_sources/complete_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error_handling/failure.dart';
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
    required List<String>? chronicConditions,
    required List<String>? allergies,
  }) async {
    try {
      final response = await completeDataSource.completeSignUp(
        weight: weight,
        height: height,
        bloodType: bloodType,
        gender: gender,
        age: age,
        chronicConditions: chronicConditions,
        allergies: allergies,
      );

      return CompletePatientDataResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}
