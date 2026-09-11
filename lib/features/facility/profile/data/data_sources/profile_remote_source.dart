
import 'package:chefaa/core/imports/imports.dart';
abstract class ProfileRemoteSource {
  Future<Response> getProfile();
  Future<Response> updateProfile(Map<String, dynamic> body);
}
