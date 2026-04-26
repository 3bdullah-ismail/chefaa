import 'package:chefaa/presentation/patient/search/data/models/search_response.dart';
import 'package:chefaa/presentation/patient/search/data/repositories/search_repo.dart';
import 'package:chefaa/presentation/patient/search/domain/entities/doctor_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/error_handling/failure.dart';
import '../datasources/search_data_source.dart';

@Injectable(as: SearchRepo)
class SearchRepoImp implements SearchRepo {
  final SearchDataSource searchDataSource;

  SearchRepoImp(this.searchDataSource);

  @override
  Future<List<DoctorModel>?> filterSearch({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  }) async {
    try {
      final response = await searchDataSource.filterSearch(
        searchText: searchText,
        specialization: specialization,
        gender: gender,
        location: location,
      );

      final data = response.data;
      final listPayload = _extractListPayload(data);

      if (listPayload == null) {
        return [];
      }

      return listPayload
          .whereType<Map<String, dynamic>>()
          .map<DoctorModel>((e) => SearchResponse.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
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
