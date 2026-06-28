import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'auth_interceptor.dart';
import 'sanitized_dio_logger.dart';

@lazySingleton
class NetworkService {
  late Dio dio;

  NetworkService() {
    init();
  }

  void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://shefaa-backend.vercel.app/api",
        connectTimeout: const Duration(seconds: 50),
        receiveTimeout: const Duration(seconds: 50),
        followRedirects: false,
        headers: {"Accept": "application/json"},
      ),
    );

    dio.interceptors.add(AuthInterceptor());

    if (kDebugMode) {
      dio.interceptors.add(SanitizedDioLogger());
    }
  }
}
