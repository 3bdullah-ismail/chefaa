
import '../models/Complete_patient.dart';

abstract class CompletePatientRepo {
  Future<CompletePatient>completeSignUp({
    required double? weight,
    required int? height,
    required String? bloodType,
    required String? gender,
    required int? age,
    required List<String>? chronicDiseases,
    required List<String>? allergies,
});
}