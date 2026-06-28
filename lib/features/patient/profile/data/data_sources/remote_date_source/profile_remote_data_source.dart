import 'package:dio/dio.dart';
import '../../../domain/entities/address_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<Response> getProfileData();

  Future<Response> updateProfileData(
    String? name,
    String? gender,
    num? age,
    num? height,
    num? weight,
      AddressEntity address,
  );

  Future<Response<dynamic>> updateMedicalData({
    required String bloodType,
    required List<String> allergiesList,
    required List<String> chronicConditionsList,
  });
}
