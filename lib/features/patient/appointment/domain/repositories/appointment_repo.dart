import 'package:chefaa/features/patient/appointment/data/models/appointment_model.dart';

abstract class AppointmentRepo {
  Future<List<AppointmentModel>> getMyAppointments();

  Future<AppointmentModel> rescheduleAppointment({
    required String appointmentId,
    required String date,
    required String slotStart,
    required String slotEnd,
    required String timeChosed,
  });

  Future<AppointmentModel> cancelAppointment({required String appointmentId});
}
