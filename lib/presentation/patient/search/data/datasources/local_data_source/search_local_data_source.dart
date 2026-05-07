import 'package:chefaa/presentation/patient/search/domain/entities/clinic_model.dart';

abstract class SearchLocalDataSource {
  Future<List<String>> getSearchHistory();

  Future<void> saveSearchHistory(String searchText);

  Future<void> clearSearchHistory();

  Future<List<ClinicModel>?> getCachedDoctors({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  });

  Future<void> cacheDoctors({
    required List<ClinicModel> doctors,
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
