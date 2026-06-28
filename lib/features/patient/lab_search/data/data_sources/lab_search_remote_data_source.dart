import 'package:dio/dio.dart';

abstract class LabSearchRemoteDataSource {
  Future<Response<dynamic>> searchCenters({
    String? requiredServices,
    bool? homeService,
  });
}
