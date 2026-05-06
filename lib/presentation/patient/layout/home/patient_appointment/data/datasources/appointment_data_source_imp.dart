import 'package:chefaa/core/services/network_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'appointment_data_source.dart';

@Injectable(as: AppointmentDataSource)
class AppointmentDataSourceImpl implements AppointmentDataSource {
  NetworkService networkService;
  AppointmentDataSourceImpl(this.networkService);

  @override
  Future<Response<dynamic>> cancelAppointments({
    required String appointmentId,
  }) {
    return networkService.dio.delete("/appointments/$appointmentId/cancel");
  }

  @override
  Future<Response<dynamic>> getAppointments() {
    return networkService.dio.get("/appointments/my");
  }

  @override
  Future<Response<dynamic>> getSpecificDayAppointments({
    required String appointmentId,
    required String date,
  }) {
    return networkService.dio.get(
      "/clinic/$appointmentId/day-slots?date=$date",
    );
  }

  @override
  Future<Response<dynamic>> rescheduleAppointments({
    required String appointmentId,
    required String newDate,
    required String slotStart,
    required String slotEnd,
    required String timeChoose,
  }) {
    return networkService.dio.post(
      "/appointments/$appointmentId/reschedule",
      data: {
        "new_date": newDate,
        "slot_start": slotStart,
        "slot_end": slotEnd,
        "time_choose": timeChoose,
      },
    );
  }
}
