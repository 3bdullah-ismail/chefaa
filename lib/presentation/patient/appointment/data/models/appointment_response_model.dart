import 'package:chefaa/presentation/patient/appointment/data/models/appointment_model.dart';

class AppointmentResponseModel {
  final bool? success;
  final int? count;
  final String? message;
  final List<AppointmentModel>? appointments;
  final AppointmentModel? appointment;

  const AppointmentResponseModel({
    this.success,
    this.count,
    this.message,
    this.appointments,
    this.appointment,
  });

  factory AppointmentResponseModel.fromJsonList(dynamic json) {
    final dynamic data = json['data'];

    List<AppointmentModel>? appointmentList;
    if (data is List) {
      appointmentList = data
          .map((item) => AppointmentModel.fromJson(item))
          .toList();
    }

    return AppointmentResponseModel(
      success: json['success'],
      count: json['count'],
      message: json['message'],
      appointments: appointmentList,
    );
  }

  factory AppointmentResponseModel.fromJsonSingle(dynamic json) {
    final dynamic data = json['data'];

    AppointmentModel? singleAppointment;
    if (data is Map<String, dynamic>) {
      singleAppointment = AppointmentModel.fromJson(data);
    }

    return AppointmentResponseModel(
      success: json['success'],
      message: json['message'],
      appointment: singleAppointment,
    );
  }
}
