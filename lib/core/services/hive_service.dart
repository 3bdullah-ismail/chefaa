import 'dart:developer' as developer;

import 'package:hive_flutter/hive_flutter.dart';

import '../../presentation/patient/search/domain/entities/doctor_model.dart';

class HiveService {
  HiveService._();

  static const String _logTag = 'HiveService';

  static Future<void> init() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(DoctorModelAdapter());
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

  static Future<Box> _openBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox(boxName);
    }
    return Hive.box(boxName);
  }

  /// Retrieve a value from Hive
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

  /// Store a value in Hive
  static Future<void> put(String boxName, String key, dynamic value) async {
    try {
      final box = await _openBox(boxName);
      await box.put(key, value);
      developer.log('Put success: $boxName/$key', name: _logTag);
    } catch (e) {
      developer.log('Put error: $e', name: _logTag, level: 1000);
    }
  }

  /// Delete a key from Hive
  static Future<void> delete(String boxName, String key) async {
    try {
      final box = await _openBox(boxName);
      await box.delete(key);
      developer.log('Delete success: $boxName/$key', name: _logTag);
    } catch (e) {
      developer.log('Delete error: $e', name: _logTag, level: 1000);
    }
  }

  /// Clear all data from a box
  static Future<void> clear(String boxName) async {
    try {
      final box = await _openBox(boxName);
      await box.clear();
      developer.log('Clear success: $boxName', name: _logTag);
    } catch (e) {
      developer.log('Clear error: $e', name: _logTag, level: 1000);
    }
  }

  /// Check if a key exists in the box
  static Future<bool> containsKey(String boxName, String key) async {
    try {
      final box = await _openBox(boxName);
      return box.containsKey(key);
    } catch (e) {
      developer.log('ContainsKey error: $e', name: _logTag, level: 1000);
      return false;
    }
  }

  /// Get all values from a box
  static Future<List<dynamic>> getAll(String boxName) async {
    try {
      final box = await _openBox(boxName);
      return box.values.toList();
    } catch (e) {
      developer.log('GetAll error: $e', name: _logTag, level: 1000);
      return [];
    }
  }

  /// Get the number of items in a box
  static Future<int> getLength(String boxName) async {
    try {
      final box = await _openBox(boxName);
      return box.length;
    } catch (e) {
      developer.log('GetLength error: $e', name: _logTag, level: 1000);
      return 0;
    }
  }

  /// Check if a box is open
  static bool isBoxOpen(String boxName) {
    return Hive.isBoxOpen(boxName);
  }

  /// Close a specific box
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

  /// Close all boxes
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
  static const String doctorsBox = 'doctors_box';
}
