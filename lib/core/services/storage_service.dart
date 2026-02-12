import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../presentation/patient/auth/data/models/patient.dart';

class StorageService {
  static String? token;
  static Patient? patient;
  static const _storage = FlutterSecureStorage(aOptions: AndroidOptions());
  static Future<void> saveToken(String value) {
    token = value;
    return _storage.write(key: 'token', value: value);
  }

  static Future<String?> getToken() async {
    final value = await _storage.read(key: 'token');
    token = value;
    return value;
  }
  static Future<void> savePatient(Patient value) async {
    final jsonString = jsonEncode(value.toJson());
    await _storage.write(key: 'patient', value: jsonString);
    patient = value;
  }

  static Future<void> clearAll() async => await _storage.deleteAll();
}
