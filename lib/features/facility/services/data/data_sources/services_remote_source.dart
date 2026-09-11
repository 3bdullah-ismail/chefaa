
import 'package:chefaa/core/imports/imports.dart';
abstract class ServicesRemoteSource {
  Future<Response> addService({
    required String name,
    required String category,
    required num price,
    required String estimatedTime,
    String? sessionDuration,
    String? instructions,
    String? imagePath,
  });

  Future<Response> getMyServices({String? search});

  Future<Response> toggleService(String serviceId);
}
