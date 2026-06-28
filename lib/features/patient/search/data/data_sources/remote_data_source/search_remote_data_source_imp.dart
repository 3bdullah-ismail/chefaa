import 'package:chefaa/features/patient/search/data/data_sources/remote_data_source/search_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/core/services/network_service.dart';

@Injectable(as: SearchRemoteDataSource)
class SearchDataSourceImp implements SearchRemoteDataSource {
  NetworkService networkService;

  SearchDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> filterSearch({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  }) {
    final params = {
      if (searchText != null && searchText.isNotEmpty) 'searchText': searchText,
      if (specialization != null && specialization.isNotEmpty)
        'specialization': specialization,
      if (gender != null && gender.isNotEmpty) 'gender': gender,
      if (location != null && location.isNotEmpty) 'location': location,
    };

    return networkService.dio.get(
      '/doctor/search-doctors',
      queryParameters: params,
    );
  }
}
