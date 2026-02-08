import 'package:chefaa/core/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkService {
  late Dio dio;
  NetworkService() {
    intl();
  }
  void intl() async {
    dio = Dio(
      BaseOptions(
        baseUrl: "",
        followRedirects: false,
        headers: {
          if (StorageService.token != null) "token": StorageService.token,
        },
      ),
    );
    dio.interceptors.add(
      PrettyDioLogger(requestBody: true, request: true, requestHeader: true),
    );
  }
}
