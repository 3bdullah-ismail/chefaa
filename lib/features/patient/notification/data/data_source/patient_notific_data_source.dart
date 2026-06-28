import 'package:dio/dio.dart';

abstract class PatientNotificatorDataSource {
  Future<Response>getNotifications();
}