import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/lab_search/data/models/search_centers_response.dart';

abstract class LabSearchRepo {
  Future<Either<Failure, SearchCentersResponse>> searchCenters({
    String? requiredServices,
    bool? homeService,
  });
}
