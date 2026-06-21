import 'package:dio/dio.dart';

abstract class PatientsDataSource {
  Future<Response> getPatients();
}