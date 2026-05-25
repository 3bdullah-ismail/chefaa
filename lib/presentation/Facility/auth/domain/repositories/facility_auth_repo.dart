import 'package:chefaa/core/models/auth_response.dart';
import 'package:file_picker/file_picker.dart';

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
