import 'package:chefaa/presentation/patient/layout/search/data/repositories/search_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/error_handling/failure.dart';
import '../../domain/entities/doctor_clinic.dart';
import '../datasources/search_data_source.dart';

@Injectable(as: SearchRepo)
class SearchRepoImp implements SearchRepo {
  final SearchDataSource searchDataSource;

  SearchRepoImp(this.searchDataSource);

  @override
  Future<List<DoctorClinic>?> filterSearch({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  }) async {
    try {
      final response = await searchDataSource.filterSearch(
        specialization: specialization,
        gender: gender,
        location: location,
      );

      final data = response.data;

      if (data == null || data is! List) {
        return [];
      }

      return data.map<DoctorClinic>((e) => DoctorClinic.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw 'Failed to fetch doctors. Please try again.';
    }
  }
}
