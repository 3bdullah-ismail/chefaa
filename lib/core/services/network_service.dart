import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class NetworkService {
  late Dio dio;

  NetworkService() {
    intl();
  }

  void intl() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://shefaa-backend.vercel.app/api",
        followRedirects: false,
      ),
    );
    dio.interceptors.add(
      PrettyDioLogger(requestBody: true, request: true, requestHeader: true),
    );
  }
}
