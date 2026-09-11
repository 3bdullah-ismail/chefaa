import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/features/auth/data/models/auth_response.dart';

abstract class FacilityAuthRepo {
  Future<AuthResponse> signUP({
    required String name,
    required String username,
    required String email,
    required String password,
    required String commercialRegisterNumber,
    required String facilityType,
    required String medicalDirectorName,
    required String directorProfessionalId,
    required String phoneNumber,
    required PlatformFile medicalLicence,
  });
}
