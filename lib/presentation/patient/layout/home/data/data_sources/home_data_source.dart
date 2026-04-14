import 'package:dio/dio.dart';

abstract class HomeDataSource {
  Future<Response> getAppointments();


}
