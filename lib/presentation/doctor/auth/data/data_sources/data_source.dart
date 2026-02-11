import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

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
