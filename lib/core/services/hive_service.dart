import 'dart:developer' as developer;

import 'package:chefaa/features/patient/search/domain/entities/clinic_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  HiveService._();

  static const String _logTag = 'HiveService';

  static Future<void> init() async {
    try {
      await Hive.initFlutter();
      if (!Hive.isAdapterRegistered(ClinicModelAdapter().typeId)) {
        Hive.registerAdapter(ClinicModelAdapter());
      }

      developer.log('Hive initialized successfully', name: _logTag);
    } catch (e) {
      developer.log(
        'Hive initialization error: $e',
        name: _logTag,
        level: 1000,
      );
      rethrow;
    }
  }

  static Future<Box<dynamic>> openBox(String boxName) {
    return _openBox(boxName);
  }

  static Future<Box<dynamic>> _openBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      try {
        return await Hive.openBox<dynamic>(boxName);
      } catch (e) {
        if (_shouldResetBox(e)) {
          await _deleteBoxFromDisk(boxName);
          return await Hive.openBox<dynamic>(boxName);
        }

        rethrow;
      }
    }

    return Hive.box<dynamic>(boxName);
  }

  static bool _shouldResetBox(Object error) {
    final message = error.toString().toLowerCase();
    return message.contains('unknown typeid') ||
        message.contains("type 'null' is not a subtype") ||
        message.contains('corrupt');
  }

  static Future<void> _deleteBoxFromDisk(String boxName) async {
    try {
      if (Hive.isBoxOpen(boxName)) {
        await Hive.box<dynamic>(boxName).close();
      }
    } catch (e) {
      developer.log(
        'Error closing box before reset ($boxName): $e',
        name: _logTag,
        level: 1000,
      );
    }

    try {
      await Hive.deleteBoxFromDisk(boxName);
      developer.log(
        'Deleted incompatible box from disk: $boxName',
        name: _logTag,
      );
    } catch (e) {
      developer.log(
        'Error deleting box from disk ($boxName): $e',
        name: _logTag,
        level: 1000,
      );
    }
  }

  static Future<T?> get<T>(
    String boxName,
    String key, {
    T? defaultValue,
  }) async {
    try {
      final box = await _openBox(boxName);
      final value = box.get(key, defaultValue: defaultValue);
      return value is T ? value : defaultValue;
    } catch (e) {
      developer.log('Get error: $e', name: _logTag, level: 1000);
      return defaultValue;
    }
  }

  static Future<void> put(String boxName, String key, dynamic value) async {
    try {
      final box = await _openBox(boxName);
      await box.put(key, value);
      developer.log('Put success: $boxName/$key', name: _logTag);
    } catch (e) {
      developer.log('Put error: $e', name: _logTag, level: 1000);
    }
  }

  static Future<void> delete(String boxName, String key) async {
    try {
      final box = await _openBox(boxName);
      await box.delete(key);
      developer.log('Delete success: $boxName/$key', name: _logTag);
    } catch (e) {
      developer.log('Delete error: $e', name: _logTag, level: 1000);
    }
  }

  static Future<void> clear(String boxName) async {
    try {
      final box = await _openBox(boxName);
      await box.clear();
      developer.log('Clear success: $boxName', name: _logTag);
    } catch (e) {
      developer.log('Clear error: $e', name: _logTag, level: 1000);
    }
  }

  static Future<bool> containsKey(String boxName, String key) async {
    try {
      final box = await _openBox(boxName);
      return box.containsKey(key);
    } catch (e) {
      developer.log('ContainsKey error: $e', name: _logTag, level: 1000);
      return false;
    }
  }

  static Future<List<dynamic>> getAll(String boxName) async {
    try {
      final box = await _openBox(boxName);
      return box.values.toList();
    } catch (e) {
      developer.log('GetAll error: $e', name: _logTag, level: 1000);
      return [];
    }
  }

  static Future<int> getLength(String boxName) async {
    try {
      final box = await _openBox(boxName);
      return box.length;
    } catch (e) {
      developer.log('GetLength error: $e', name: _logTag, level: 1000);
      return 0;
    }
  }

  static bool isBoxOpen(String boxName) {
    return Hive.isBoxOpen(boxName);
  }

  static Future<void> closeBox(String boxName) async {
    try {
      if (Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).close();
        developer.log('Box closed: $boxName', name: _logTag);
      }
    } catch (e) {
      developer.log('Close box error: $e', name: _logTag, level: 1000);
    }
  }

  static Future<void> closeAllBoxes() async {
    try {
      await Hive.close();
      developer.log('All boxes closed', name: _logTag);
    } catch (e) {
      developer.log('Close all boxes error: $e', name: _logTag, level: 1000);
    }
  }
}

class HiveBoxes {
  static const String doctorsBox = 'search_cache_v2';
  static const String reportsBox = 'reports';
  static const String facilityBox = 'facility_cache_v1';
}
