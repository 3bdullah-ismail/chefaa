import 'package:chefaa/presentation/facility/services/data/models/add_service_response.dart';
import 'package:chefaa/presentation/facility/services/data/models/get_services_response.dart';

abstract class ServicesRepository {
  Future<AddServiceResponse> addService({
    required String name,
    required String category,
    required num price,
    required String estimatedTime,
    String? sessionDuration,
    String? instructions,
    String? imagePath,
  });

  Future<GetServicesResponse> getMyServices({String? search});

  Future<AddServiceResponse> toggleService(String serviceId);
}
