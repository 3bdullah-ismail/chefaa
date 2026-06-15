import 'package:chefaa/presentation/patient/search/domain/entities/clinic_model.dart';

abstract class SearchLocalDataSource {
  Future<List<String>> getSearchHistory();

  Future<void> saveSearchHistory(String searchText);

  Future<void> clearSearchHistory();

  Future<(List<ClinicModel>? doctors, bool isFresh)> getCachedDoctors({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
    Duration maxAge = const Duration(minutes: 10),
  });

  Future<void> updateCache({
    required List<ClinicModel> doctors,
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  });
}
