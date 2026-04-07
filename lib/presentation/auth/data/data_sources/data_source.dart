import 'package:dio/dio.dart';

abstract class AuthDataSource {
  Future<Response> forgotPass({required String identity});

  Future<Response> resetCode({required String code, required String identity});

  Future<Response> resetPass({
    required String identity,
    required String code,
    required String newPassword,
  });

  Future<Response> login({required String identity, required String password});

  Future<Response> googleSignIn(String idToken);
}
