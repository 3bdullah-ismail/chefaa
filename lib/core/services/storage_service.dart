import 'dart:convert';

import 'package:chefaa/core/models/auth_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static String? token;
  static User? user;
  static String? role;

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
    final jsonString = jsonEncode(value.toJson());
    await _storage.write(key: 'user', value: jsonString);
    user = value;
  }

  static Future<User?> getUser() async {
    final jsonString = await _storage.read(key: 'user');
    if (jsonString == null) return null;

    final userData = User.fromJson(jsonDecode(jsonString));
    user = userData;
    return userData;
  }

  static Future<void> saveRole(String value) async {
    role = value;
    await _storage.write(key: 'role', value: value);
  }

  static Future<String?> getRole() async {
    final value = await _storage.read(key: 'role');
    role = value;
    return value;
  }

  static Future<void> clearAll() async => await _storage.deleteAll();
}
