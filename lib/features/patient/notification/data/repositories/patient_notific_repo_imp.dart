import 'package:chefaa/features/patient/notification/data/data_sources/patient_notific_data_source.dart';
import 'package:chefaa/features/patient/notification/data/models/notification.dart';
import 'package:chefaa/features/patient/notification/domain/repositories/patient_notific_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/core/error_handling/failure.dart';

@Injectable(as: PatientNotificatorRepo)
class PatientNotificatorRepoImp implements PatientNotificatorRepo {
  PatientNotificatorDataSource patientNotificatorDataSource;

  PatientNotificatorRepoImp({required this.patientNotificatorDataSource});

  @override
  Future<List<Notification>> getNotifications() async {
    try {
      final notificationResponse = await patientNotificatorDataSource
          .getNotifications();
      final notifications = (notificationResponse.data as List)
          .map((notificationJson) => Notification.fromJson(notificationJson))
          .toList();
      return notifications;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}

