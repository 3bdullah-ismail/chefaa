import 'package:chefaa/presentation/patient/appointment/data/models/appointment_model.dart';

sealed class AppointmentState {}

final class AppointmentInitialState extends AppointmentState {}

final class GetAppointmentsLoadingState extends AppointmentState {}

final class GetAppointmentsSuccessState extends AppointmentState {
  final List<AppointmentModel> appointments;

  GetAppointmentsSuccessState({required this.appointments});
}

final class GetAppointmentsErrorState extends AppointmentState {
  final String error;

  GetAppointmentsErrorState({required this.error});
}

final class RescheduleLoadingState extends AppointmentState {}

final class RescheduleSuccessState extends AppointmentState {
  final AppointmentModel appointment;

  RescheduleSuccessState({required this.appointment});
}

final class RescheduleErrorState extends AppointmentState {
  final String error;

  RescheduleErrorState({required this.error});
}

final class CancelAppointmentLoadingState extends AppointmentState {}

final class CancelAppointmentSuccessState extends AppointmentState {
  final AppointmentModel appointment;

  CancelAppointmentSuccessState({required this.appointment});
}

final class CancelAppointmentErrorState extends AppointmentState {
  final String error;

  CancelAppointmentErrorState({required this.error});
}

