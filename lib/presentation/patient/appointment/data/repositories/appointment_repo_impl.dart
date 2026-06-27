import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/presentation/patient/appointment/data/data_sources/appointment_remote_data_source.dart';
import 'package:chefaa/presentation/patient/appointment/data/models/appointment_model.dart';
import 'package:chefaa/presentation/patient/appointment/data/models/appointment_response_model.dart';
import 'package:chefaa/presentation/patient/appointment/data/models/reschedule_appointment_request_model.dart';
import 'package:chefaa/presentation/patient/appointment/data/repositories/appointment_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AppointmentRepo)
class AppointmentRepoImpl implements AppointmentRepo {
  final AppointmentRemoteDataSource remoteDataSource;

  AppointmentRepoImpl(this.remoteDataSource);

  @override
  Future<List<AppointmentModel>> getMyAppointments() async {
    try {
      final response = await remoteDataSource.getMyAppointments();
      final model = AppointmentResponseModel.fromJsonList(response.data);
      return model.appointments ?? [];
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } catch (e) {
      // print("ERROR = $e");
      // print(s);
      rethrow;
    }
  }

  @override
  Future<AppointmentModel> rescheduleAppointment({
    required String appointmentId,
    required String date,
    required String slotStart,
    required String slotEnd,
    required String timeChosed,
  }) async {
    try {
      final requestModel = RescheduleAppointmentRequestModel(
        date: date,
        slotStart: slotStart,
        slotEnd: slotEnd,
        timeChosed: timeChosed,
      );

      final response = await remoteDataSource.rescheduleAppointment(
        appointmentId: appointmentId,
        requestModel: requestModel,
      );

      final model = AppointmentResponseModel.fromJsonSingle(response.data);

      if (model.appointment == null) {
        throw ServerFailure('Rescheduled appointment data is missing.');
      }

      return model.appointment!;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } on ServerFailure {
      rethrow;
    } catch (_) {
      throw ServerFailure(ServerFailure.unexpectedError);
    }
  }

  @override
  Future<AppointmentModel> cancelAppointment({
    required String appointmentId,
  }) async {
    try {
      final response = await remoteDataSource.cancelAppointment(
        appointmentId: appointmentId,
      );

      final model = AppointmentResponseModel.fromJsonSingle(response.data);

      if (model.appointment == null) {
        throw ServerFailure('Cancelled appointment data is missing.');
      }

      return model.appointment!;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e);
    } on ServerFailure {
      rethrow;
    } catch (_) {
      throw ServerFailure(ServerFailure.unexpectedError);
    }
  }
}
