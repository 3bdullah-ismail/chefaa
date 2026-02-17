import 'package:chefaa/core/models/auth_response.dart';

abstract class PatientRepo {
  Future<AuthResponse> patientSignUp({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
  });
}
