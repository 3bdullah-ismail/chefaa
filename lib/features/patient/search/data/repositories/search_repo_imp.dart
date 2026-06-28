import 'package:chefaa/features/patient/search/data/data_sources/local_data_source/search_local_data_source.dart';
import 'package:chefaa/features/patient/search/data/data_sources/remote_data_source/search_remote_data_source.dart';
import 'package:chefaa/features/patient/search/data/models/search_response.dart';
import 'package:chefaa/features/patient/search/domain/repositories/search_repo.dart';
import 'package:chefaa/features/patient/search/domain/entities/clinic_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/core/error_handling/failure.dart';

@Injectable(as: SearchRepo)
class SearchRepoImp implements SearchRepo {
  final SearchRemoteDataSource searchDataSource;
  final SearchLocalDataSource searchLocalDataSource;

  SearchRepoImp(this.searchDataSource, this.searchLocalDataSource);

  @override
  Future<List<ClinicModel>?> filterSearch({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  }) async {
    final (cached, isFresh) = await searchLocalDataSource.getCachedDoctors(
      searchText: searchText,
      specialization: specialization,
      gender: gender,
      location: location,
    );

    if (cached != null && isFresh) {
      return cached;
    }

    try {
      final response = await searchDataSource.filterSearch(
        searchText: searchText,
        specialization: specialization,
        gender: gender,
        location: location,
      );

      final listPayload = _extractListPayload(response.data);
      if (listPayload == null) {
        return cached ?? <ClinicModel>[];
      }

      final doctors = SearchResponse.fromJsonList(
        listPayload,
      ).map<ClinicModel>((e) => e).toList(growable: false);

      await searchLocalDataSource.updateCache(
        doctors: doctors,
        searchText: searchText,
        specialization: specialization,
        gender: gender,
        location: location,
      );

      await searchLocalDataSource.saveSearchHistory(searchText ?? '');

      return doctors;
    } on DioException catch (e) {
      if (cached != null) {
        return cached;
      }
      throw ServerFailure.fromDioError(e).message;
    } catch (_) {
      if (cached != null) {
        return cached;
      }
      throw 'Failed to fetch doctors. Please try again.';
    }
  }

  List<dynamic>? _extractListPayload(dynamic data) {
    if (data is List<dynamic>) return data;
    if (data is! Map<String, dynamic>) return null;

    final candidates = [
      data['data'],
      data['docs'],
      data['results'],
      data['items'],
      data['doctors'],
    ];

    for (final candidate in candidates) {
      if (candidate is List<dynamic>) return candidate;
    }

    return null;
  }
}
