import 'package:chefaa/presentation/patient/notification/data/models/Notification.dart';

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