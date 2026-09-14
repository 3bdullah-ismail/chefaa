import 'package:chefaa/core/imports/imports.dart';

abstract class HomeDataSource {
  Future<Response> getAppointments();
}
