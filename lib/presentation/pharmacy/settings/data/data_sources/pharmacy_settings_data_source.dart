import 'package:dio/dio.dart';

abstract class PharmacySettingsDataSource {
  Future<Response> updateStatus(Map<String, dynamic> body);
}
