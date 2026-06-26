import 'package:dio/dio.dart';

abstract class PharmacyRemoteDataSource {
  Future<Response<dynamic>> getPharmacyProfile(String pharmacyId);
}
