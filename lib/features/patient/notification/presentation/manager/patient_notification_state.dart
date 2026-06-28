import 'package:chefaa/features/patient/notification/data/models/notification.dart';

sealed class PatientNotificationState {}
class PatientNotificationInitialState extends PatientNotificationState {}
class PatientNotificationLoadingState extends PatientNotificationState {}
class PatientNotificationSuccessState extends PatientNotificationState {
  final List<Notification> notification;
  PatientNotificationSuccessState({required this.notification});
}
class PatientNotificationErrorState extends PatientNotificationState {
  final String errorMessage;
  PatientNotificationErrorState({required this.errorMessage});
}
