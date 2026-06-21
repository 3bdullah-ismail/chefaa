import 'dart:convert';

import 'package:chefaa/core/services/hive_service.dart';
import 'package:chefaa/presentation/patient/search/data/data_sources/local_data_source/search_local_data_source.dart';
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

    if (history.length > 20) {
      history.removeRange(20, history.length);
    }

    await HiveService.put(HiveBoxes.doctorsBox, _historyKey, history);
  }

  @override
  Future<(List<ClinicModel>? doctors, bool isFresh)> getCachedDoctors({
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
    final entry = await _getCacheEntry(key);
    if (entry == null) {
      return (null, false);
    }

    final items = entry['items'];
    final doctors = items is List
        ? items.whereType<ClinicModel>().toList(growable: false)
        : null;

    final updatedAtMillis = entry['updatedAt'];
    var isFresh = false;
    if (updatedAtMillis is int) {
      final updatedAt = DateTime.fromMillisecondsSinceEpoch(updatedAtMillis);
      isFresh = DateTime.now().difference(updatedAt) <= maxAge;
    }

    return (doctors, isFresh);
  }

  @override
  Future<void> updateCache({
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
    final entry = await _getCacheEntry(key);
    final existingItems = entry?['items'];

    final oldList = existingItems is List ? existingItems.whereType<ClinicModel>().toList(growable: false) : null;
    
    if (_areDoctorsEquivalent(oldList, doctors)) {
      return;
    }

    await _saveCacheEntry(key, doctors);
  }

  bool _areDoctorsEquivalent(List<ClinicModel>? oldList, List<ClinicModel> newList) {
    if (oldList == null || oldList.length != newList.length) {
      return false;
    }

    final oldJson = jsonEncode(oldList.map((e) => e.toJson()).toList());
    final newJson = jsonEncode(newList.map((e) => e.toJson()).toList());

    return oldJson == newJson;
  }

  Future<Map<dynamic, dynamic>?> _getCacheEntry(String key) async {
    final raw = await HiveService.get<dynamic>(HiveBoxes.doctorsBox, key);
    return raw is Map ? raw : null;
  }

  Future<void> _saveCacheEntry(String key, List<dynamic> items) async {
    final payload = <String, dynamic>{
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
      'items': items,
    };
    await HiveService.put(HiveBoxes.doctorsBox, key, payload);
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
