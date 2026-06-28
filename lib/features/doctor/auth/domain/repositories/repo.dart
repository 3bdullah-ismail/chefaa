import 'package:chefaa/features/auth/data/models/auth_response.dart';
import 'package:file_picker/file_picker.dart';

abstract class DoctorAuthRepo {
  Future<AuthResponse> signUp({
    required String name,
    required String email,
    required String username,
    required String password,
    required String phoneNumber,
    required String specialization,
    required PlatformFile membership,
  });
}
