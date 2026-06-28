import 'package:chefaa/features/patient/appointment/data/models/reschedule_appointment_request_model.dart';
import 'package:dio/dio.dart';

abstract class AppointmentRemoteDataSource {
  Future<Response> getMyAppointments();

  Future<Response> rescheduleAppointment({
    required String appointmentId,
    required RescheduleAppointmentRequestModel requestModel,
  });

  Future<Response> cancelAppointment({required String appointmentId});
}
