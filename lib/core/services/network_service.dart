import 'package:chefaa/core/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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

    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
      ),
    );
  }
}
