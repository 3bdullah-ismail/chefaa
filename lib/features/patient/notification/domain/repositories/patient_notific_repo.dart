import 'package:chefaa/features/patient/notification/data/models/notification.dart';

abstract class PatientNotificatorRepo {
  Future<List<Notification>> getNotifications();
}
