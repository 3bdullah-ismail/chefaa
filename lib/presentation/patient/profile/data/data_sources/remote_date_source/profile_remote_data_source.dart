import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource {
  Future<Response> getProfileData();
  Future<Response> updateProfileData();
  Future<Response<dynamic>> updateMedicalData({
    required String bloodType,
    required List<String> allergiesList,
    required List<String> chronicConditionsList,
  });
}
