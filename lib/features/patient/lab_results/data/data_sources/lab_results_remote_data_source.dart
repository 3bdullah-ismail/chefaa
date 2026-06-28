import 'package:dio/dio.dart';

abstract class LabResultsRemoteDataSource {
  Future<Response> getLabResults();
}
