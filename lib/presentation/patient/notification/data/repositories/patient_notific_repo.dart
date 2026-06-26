import 'package:chefaa/presentation/patient/notification/data/models/Notification.dart';

abstract class PatientNotificatorRepo {
  Future<List<Notification>> getNotifications();
}