import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/presentation/patient/lab_search/data/remote/data_sources/lab_search_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LabSearchRemoteDataSource)
class LabSearchRemoteDataSourceImpl implements LabSearchRemoteDataSource {
  final NetworkService _networkService;

  LabSearchRemoteDataSourceImpl(this._networkService);

  @override
  Future<Response<dynamic>> searchCenters({
    String? requiredServices,
    bool? homeService,
  }) async {
    final Map<String, dynamic> queryParams = {};
    if (requiredServices != null && requiredServices.isNotEmpty) {
      queryParams["requiredServices"] = requiredServices;
    }
    if (homeService != null) {
      queryParams["homeService"] = homeService;
    }

    final response = await _networkService.dio.get(
      "/patient/search-centers",
      queryParameters: queryParams,
    );

    return response;
  }
}
