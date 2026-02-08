import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static String? token;
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

  static Future<void> clearAll() async => await _storage.deleteAll();
}
