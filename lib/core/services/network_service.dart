import 'package:chefaa/core/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';
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
        followRedirects: false,
        headers: {"Content-Type": "application/json"},
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

    // Limit heavy logging and use debugPrint (throttled) to avoid blocking the
    // UI thread when large request/response bodies (e.g. JWTs) are printed.
    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        // Disable printing full request/response bodies by default because
        // very large bodies cause UI jank in debug on some devices.
        requestBody: false,
        responseBody: false,
        responseHeader: false,
        error: true,
        // Use Flutter's debugPrint which is throttled and safer for large logs.
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    );
    dio.interceptors.add(AuthInterceptor());
  }
}
