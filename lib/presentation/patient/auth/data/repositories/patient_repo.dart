


import '../models/Potient_data.dart';

abstract class PatientRepo {
  Future<PatientData>patientSignUp({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
});
}