import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/presentation/patient/lab_search/data/remote/data_sources/lab_search_remote_data_source.dart';
import 'package:chefaa/presentation/patient/lab_search/data/remote/models/search_centers_response.dart';
import 'package:chefaa/presentation/patient/lab_search/data/repositories/lab_search_repo.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LabSearchRepo)
class LabSearchRepoImpl implements LabSearchRepo {
  final LabSearchRemoteDataSource _remoteDataSource;

  LabSearchRepoImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, SearchCentersResponse>> searchCenters({
    String? requiredServices,
    bool? homeService,
  }) async {
    try {
      final response = await _remoteDataSource.searchCenters(
        requiredServices: requiredServices,
        homeService: homeService,
      );
      final data = SearchCentersResponse.fromJson(response.data);
      return Right(data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
