import 'package:chefaa/core/imports/imports.dart';

abstract class PharmacyDataSource {
  Future<Response> pharmacySignUp({
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
