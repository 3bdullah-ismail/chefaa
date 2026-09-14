import 'package:chefaa/core/imports/imports.dart';

abstract class PharmacySettingsDataSource {
  Future<Response> updateStatus(Map<String, dynamic> body);
}
