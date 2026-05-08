import 'dart:convert';

import 'package:chefaa/core/models/auth_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static String? token;
  static User? user;
  static String? role;

  static const _onboardingKey = 'has_seen_onboarding';

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

  static Future<void> saveUser(User value) async {
    final jsonString = await compute(_encodeUser, value.toJson());
    await _storage.write(key: 'user', value: jsonString);
    user = value;
  }

  static Future<User?> getUser() async {
    final jsonString = await _storage.read(key: 'user');
    if (jsonString == null) return null;

    final Map<String, dynamic> userMap = await compute(_decodeUser, jsonString);
    final userData = User.fromJson(userMap);
    user = userData;
    return userData;
  }

  static String _encodeUser(Map<String, dynamic> map) => jsonEncode(map);

  static Map<String, dynamic> _decodeUser(String jsonString) =>
      jsonDecode(jsonString) as Map<String, dynamic>;

  static Future<void> saveRole(String value) async {
    role = value;
    await _storage.write(key: 'role', value: value);
  }

  static Future<String?> getRole() async {
    final value = await _storage.read(key: 'role');
    role = value;
    return value;
  }

  static Future<bool> hasSeenOnboarding() async {
    final value = await _storage.read(key: _onboardingKey);
    return value == 'true';
  }

  static Future<void> markOnboardingSeen() async {
    await _storage.write(key: _onboardingKey, value: 'true');
  }

  static Future<void> clearAll() async => await _storage.deleteAll();
}
