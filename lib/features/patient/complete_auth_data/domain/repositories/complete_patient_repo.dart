import 'package:chefaa/features/patient/complete_auth_data/data/models/complete_patient_data_response.dart';

abstract class CompletePatientRepo {
  Future<CompletePatientDataResponse> completeSignUp({
    required double? weight,
    required int? height,
    required String? bloodType,
    required String? gender,
    required int? age,
    required List<String>? chronicConditions,
    required List<String>? allergies,
  });
}
