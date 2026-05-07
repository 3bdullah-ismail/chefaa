import 'package:dio/dio.dart';

abstract class BookingRemoteDataSource {
  Future<Response> getAvailableTimes({required String date});

  Future<String> bookAppointment({
    required String doctorId,
    required String patientId,
    required DateTime dateTime,
  });
}
