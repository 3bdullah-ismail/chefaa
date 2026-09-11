
import 'package:chefaa/core/imports/imports.dart';
abstract class LabSearchRemoteDataSource {
  Future<Response<dynamic>> searchCenters({
    String? requiredServices,
    bool? homeService,
  });
}
