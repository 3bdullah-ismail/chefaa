import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/features/auth/data/models/auth_response.dart';

abstract class PharmacyRepo {
  Future<AuthResponse> pharmacySignUp({
    required String name,
    required String username,
    required String phoneNumber,
    required String email,
    required String role,
    required String password,
    required PlatformFile medicalLicence,
    required String commercialRegisterNumber,
  });
}
