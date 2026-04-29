import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource {
  Future<Response> getProfileData();

  Future<Response> updateProfileData(
    String? name,
    String? gender,
    num? age,
    num? height,
    num? weight,
  );

  Future<Response<dynamic>> updateMedicalData({
    required String bloodType,
    required List<String> allergiesList,
    required List<String> chronicConditionsList,
  });
}
