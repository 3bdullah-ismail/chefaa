import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'auth_interceptor.dart';

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
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: false,
          maxWidth: 120,
          logPrint: (obj) => debugPrint(obj.toString()),
        ),
      );
    }
  }
}
