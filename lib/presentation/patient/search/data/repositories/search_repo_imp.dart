import 'package:chefaa/presentation/patient/search/data/datasources/local_data_source/search_local_data_source.dart';
import 'package:chefaa/presentation/patient/search/data/datasources/remote_date_source/search_remote_data_source.dart';
import 'package:chefaa/presentation/patient/search/data/models/search_response.dart';
import 'package:chefaa/presentation/patient/search/data/repositories/search_repo.dart';
import 'package:chefaa/presentation/patient/search/domain/entities/clinic_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error_handling/failure.dart';

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
    final cached = await searchLocalDataSource.getCachedDoctors(
      searchText: searchText,
      specialization: specialization,
      gender: gender,
      location: location,
    );

    final hasFreshCache = await searchLocalDataSource.hasFreshCache(
      searchText: searchText,
      specialization: specialization,
      gender: gender,
      location: location,
    );

    // Return instantly from fresh cache to avoid unnecessary loading latency.
    if (cached != null && hasFreshCache) {
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

      if (_areDoctorsEquivalent(cached, doctors)) {
        await searchLocalDataSource.touchCacheTimestamp(
          searchText: searchText,
          specialization: specialization,
          gender: gender,
          location: location,
        );
        return cached;
      }

      await searchLocalDataSource.cacheDoctors(
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

  bool _areDoctorsEquivalent(
    List<ClinicModel>? oldList,
    List<ClinicModel> newList,
  ) {
    if (oldList == null || oldList.length != newList.length) {
      return false;
    }

    for (var i = 0; i < oldList.length; i++) {
      final oldDoctor = oldList[i];
      final newDoctor = newList[i];

      if (oldDoctor.clinicId != newDoctor.clinicId ||
          oldDoctor.doctorName != newDoctor.doctorName ||
          oldDoctor.clinicPrice != newDoctor.clinicPrice ||
          oldDoctor.doctorRating != newDoctor.doctorRating ||
          oldDoctor.clinicLocation != newDoctor.clinicLocation) {
        return false;
      }
    }

    return true;
  }
}
