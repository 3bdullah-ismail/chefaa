import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

abstract class PharmacyDataSource {
  Future<Response>pharmacySignUp({
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