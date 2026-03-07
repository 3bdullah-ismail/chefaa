import 'package:chefaa/core/services/network_service.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:injectable/injectable.dart';

import 'googleSignIn_data_source.dart';

@Injectable(as: GoogleSignInDataSource)
class GoogleSignInDataSourceImp implements GoogleSignInDataSource {
  NetworkService networkService;

  GoogleSignInDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> googleSignIn(String idToken) {
    return networkService.dio.get(
      "/auth/google",
      queryParameters: {"idToken": idToken},
      options: Options(
        followRedirects: true,
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
  }
}
