import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/lab_search/data/models/search_centers_response.dart';
import 'package:dart_either/dart_either.dart';

abstract class LabSearchRepo {
  Future<Either<Failure, SearchCentersResponse>> searchCenters({
    String? requiredServices,
    bool? homeService,
  });
}
