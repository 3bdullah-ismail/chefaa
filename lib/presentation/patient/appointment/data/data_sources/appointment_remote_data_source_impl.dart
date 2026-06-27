import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/presentation/patient/appointment/data/data_sources/appointment_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/reschedule_appointment_request_model.dart';

@Injectable(as: AppointmentRemoteDataSource)
class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final NetworkService networkService;

  AppointmentRemoteDataSourceImpl(this.networkService);

  @override
  Future<Response<dynamic>> getMyAppointments() {
    return networkService.dio.get('/appointments/my');
  }

  @override
  Future<Response<dynamic>> rescheduleAppointment({
    required String appointmentId,
    required RescheduleAppointmentRequestModel requestModel,
  }) {
    return networkService.dio.patch(
      '/appointments/$appointmentId/reschedule',
      data: requestModel.toJson(),
    );
  }

  @override
  Future<Response<dynamic>> cancelAppointment({required String appointmentId}) {
    return networkService.dio.patch('/appointments/$appointmentId/cancel');
  }
}
