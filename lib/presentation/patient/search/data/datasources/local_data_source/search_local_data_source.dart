import 'package:chefaa/presentation/patient/search/domain/entities/doctor_model.dart';

abstract class SearchLocalDataSource {
  Future<List<String>> getSearchHistory();

  Future<void> saveSearchHistory(String searchText);

  Future<void> clearSearchHistory();

  Future<List<DoctorModel>?> getCachedDoctors({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  });

  Future<void> cacheDoctors({
    required List<DoctorModel> doctors,
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  });

  Future<bool> hasFreshCache({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
    Duration maxAge = const Duration(minutes: 10),
  });

  Future<void> touchCacheTimestamp({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  });
}
