import 'package:chefaa/core/services/hive_service.dart';
import 'package:chefaa/presentation/patient/search/data/datasources/local_data_source/search_local_data_source.dart';
import 'package:chefaa/presentation/patient/search/domain/entities/clinic_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchLocalDataSource)
class SearchDoctorLocalDataSourceImp extends SearchLocalDataSource {
  static const String _historyKey = 'search_history';

  @override
  Future<void> clearSearchHistory() async {
    await HiveService.put(HiveBoxes.doctorsBox, _historyKey, <String>[]);
  }

  @override
  Future<List<String>> getSearchHistory() async {
    final dynamic cached = await HiveService.get<dynamic>(
      HiveBoxes.doctorsBox,
      _historyKey,
      defaultValue: <String>[],
    );

    if (cached is List) {
      return cached.map((e) => e.toString()).toList(growable: false);
    }

    return <String>[];
  }

  @override
  Future<void> saveSearchHistory(String searchText) async {
    final trimmed = searchText.trim();
    if (trimmed.isEmpty) return;

    final history = await getSearchHistory();
    history.removeWhere((item) => item.toLowerCase() == trimmed.toLowerCase());
    history.insert(0, trimmed);

    // Keep only the most recent values to avoid unbounded box growth.
    if (history.length > 20) {
      history.removeRange(20, history.length);
    }

    await HiveService.put(HiveBoxes.doctorsBox, _historyKey, history);
  }

  @override
  Future<void> cacheDoctors({
    required List<ClinicModel> doctors,
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  }) async {
    final key = _cacheKey(
      searchText: searchText,
      specialization: specialization,
      gender: gender,
      location: location,
    );

    final payload = <String, dynamic>{
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
      'items': doctors,
    };

    await HiveService.put(HiveBoxes.doctorsBox, key, payload);
  }

  @override
  Future<List<ClinicModel>?> getCachedDoctors({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  }) async {
    final key = _cacheKey(
      searchText: searchText,
      specialization: specialization,
      gender: gender,
      location: location,
    );

    final dynamic raw = await HiveService.get<dynamic>(
      HiveBoxes.doctorsBox,
      key,
    );
    if (raw is! Map) return null;

    final dynamic items = raw['items'];
    if (items is! List) return null;

    return items.whereType<ClinicModel>().toList(growable: false);
  }

  @override
  Future<bool> hasFreshCache({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
    Duration maxAge = const Duration(minutes: 10),
  }) async {
    final key = _cacheKey(
      searchText: searchText,
      specialization: specialization,
      gender: gender,
      location: location,
    );

    final dynamic raw = await HiveService.get<dynamic>(
      HiveBoxes.doctorsBox,
      key,
    );
    if (raw is! Map) return false;

    final updatedAtMillis = raw['updatedAt'];
    if (updatedAtMillis is! int) return false;

    final updatedAt = DateTime.fromMillisecondsSinceEpoch(updatedAtMillis);
    return DateTime.now().difference(updatedAt) <= maxAge;
  }

  @override
  Future<void> touchCacheTimestamp({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  }) async {
    final key = _cacheKey(
      searchText: searchText,
      specialization: specialization,
      gender: gender,
      location: location,
    );

    final dynamic raw = await HiveService.get<dynamic>(
      HiveBoxes.doctorsBox,
      key,
    );
    if (raw is! Map) return;

    final existingItems = raw['items'];
    if (existingItems is! List) return;

    await HiveService.put(HiveBoxes.doctorsBox, key, {
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
      'items': existingItems,
    });
  }

  String _cacheKey({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  }) {
    final text = (searchText ?? '').trim().toLowerCase();
    final spec = (specialization ?? '').trim().toLowerCase();
    final gen = (gender ?? '').trim().toLowerCase();
    final loc = (location ?? '').trim().toLowerCase();

    return 'search_cache_v1|$text|$spec|$gen|$loc';
  }
}
