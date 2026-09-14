import 'package:chefaa/core/imports/imports.dart';

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
        baseUrl: "https://shefaa-two.vercel.app/api",
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
