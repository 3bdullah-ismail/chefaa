import 'package:chefaa/presentation/patient/notification/presentation/manager/patient_notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:chefaa/presentation/patient/notification/data/models/Notification.dart';

import '../../data/repositories/patient_notific_repo.dart';

@injectable
class PatientNotificationCubit extends Cubit<PatientNotificationState> {
  PatientNotificatorRepo patientNotificatorRepo;

  PatientNotificationCubit({required this.patientNotificatorRepo})
    : super(PatientNotificationInitialState());

  static PatientNotificationCubit get(BuildContext context) =>
      BlocProvider.of<PatientNotificationCubit>(context);
  Future<void>getNotification()async {
    emit(PatientNotificationLoadingState());
    try {
      final notification = await patientNotificatorRepo.getNotifications();
      emit(PatientNotificationSuccessState(notification: notification));
    } catch (e) {
      emit(PatientNotificationErrorState(errorMessage: e.toString()));
    }
  }
  Future<void> markAsRead(Notification notification ) async {
    notification.isRead = true;

    if (state is PatientNotificationSuccessState) {
      emit(
        PatientNotificationSuccessState(
          notification: List.from(
            (state as PatientNotificationSuccessState).notification,
          ),
        ),
      );
    }
  }
}
