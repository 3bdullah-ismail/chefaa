import 'package:chefaa/presentation/patient/layout/search/data/datasources/search_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/services/network_service.dart';

@Injectable(as: SearchDataSource)
class SearchDataSourceImp implements SearchDataSource{
  NetworkService networkService;
  SearchDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> filterSearch({
    String? specialization,
    String? gender,
    String? location,
  })  {
    final params = {
      if (specialization != null && specialization.isNotEmpty)
        "specialization": specialization,
      if (gender != null && gender.isNotEmpty)
        "gender": gender,
      if (location != null && location.isNotEmpty)
        "location": location,
    };

    return networkService.dio.get(
      "/doctor/search-doctors",
      queryParameters: params,
    );
  }
}