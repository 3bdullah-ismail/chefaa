import 'package:dio/dio.dart';

abstract class ProfileRemoteSource {
  Future<Response> getProfile();
  Future<Response> updateProfile(Map<String, dynamic> body);
}
