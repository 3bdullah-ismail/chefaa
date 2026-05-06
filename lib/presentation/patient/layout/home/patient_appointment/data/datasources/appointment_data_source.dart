import 'package:dio/dio.dart';

abstract class AppointmentDataSource{


  Future<Response>getAppointments();

  Future<Response>cancelAppointments({required String appointmentId});

  Future<Response>rescheduleAppointments({
  required String appointmentId,
    required String newDate,
    required String slotStart,
    required String slotEnd,
    required String timeChoose
});

  Future<Response>getSpecificDayAppointments({
    required String appointmentId,
    required String date,
  });
}