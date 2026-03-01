import 'package:dio/dio.dart';

abstract class LoginDataSource {
  Future<Response>login({
    required String identity,
    required String password,
});
}