
import 'package:chefaa/core/imports/imports.dart';
abstract class PharmacyProfileDataSource {
  Future<Response> getPharmacyProfile();
  Future<Response> updatePharmacyProfile(Map<String, dynamic> body);
}
