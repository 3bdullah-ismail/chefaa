import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/features/patient/appointment/data/models/reschedule_appointment_request_model.dart';

abstract class AppointmentRemoteDataSource {
  Future<Response> getMyAppointments();

  Future<Response> rescheduleAppointment({
    required String appointmentId,
    required RescheduleAppointmentRequestModel requestModel,
  });

  Future<Response> cancelAppointment({required String appointmentId});
}
