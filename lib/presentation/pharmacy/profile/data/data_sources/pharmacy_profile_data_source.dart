import 'package:dio/dio.dart';

abstract class PharmacyProfileDataSource {
  Future<Response> getPharmacyProfile();
  Future<Response> updatePharmacyProfile(Map<String, dynamic> body);
}
