
import 'package:chefaa/core/imports/imports.dart';
abstract class DoctorAuthDataSource {
  Future<Response> signUp({
    required String name,
    required String email,
    required String username,
    required String password,

    required String phoneNumber,
    required String specialization,
    required PlatformFile membership,
  });
}
