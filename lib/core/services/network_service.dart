import 'package:chefaa/core/services/storage_service.dart';
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

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = StorageService.token;
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          logPrint: (obj) => debugPrint(obj.toString()),
        ),
      );
    }

    dio.interceptors.add(AuthInterceptor());
  }
}
