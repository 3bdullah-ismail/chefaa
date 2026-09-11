
import 'package:chefaa/core/imports/imports.dart';
abstract class PatientDataSource {
  Future<Response> patientSignUp({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
  });
}
