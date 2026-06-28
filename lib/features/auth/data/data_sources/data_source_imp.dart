import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/features/auth/data/data_sources/data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImp implements AuthDataSource {
  NetworkService networkService;

  AuthDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> login({
    required String identity,
    required String password,
  }) {
    return networkService.dio.post(
      "/auth/login",
      data: {"identity": identity, "password": password},
    );
  }

  @override
  Future<Response<dynamic>> googleSignIn(String idToken) {
    debugPrint('AuthDataSourceImp.googleSignIn POST /auth/google/mobile idToken=${idToken.isEmpty ? "empty" : "present"}');
    return networkService.dio.post(
      "/auth/google/mobile",
      data: {"idToken": idToken},
    );
  }

  @override
  Future<Response<dynamic>> forgotPass({required String identity}) {
    return networkService.dio.post(
      "/auth/forgot-password",
      data: {"identity": identity},
    );
  }

  @override
  Future<Response<dynamic>> resetCode({
    required String code,
    required String identity,
  }) {
    return networkService.dio.post(
      "/auth/verify-reset-code",
      data: {"identity": identity, "code": code},
    );
  }

  @override
  Future<Response<dynamic>> resetPass({
    required String identity,
    required String code,
    required String newPassword,
  }) {
    return networkService.dio.post(
      "/auth/reset-password",
      data: {"identity": identity, "code": code, "newPassword": newPassword},
    );
  }
}
