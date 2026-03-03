import 'package:chefaa/core/services/network_service.dart';
import 'package:dio/src/response.dart';
import 'package:injectable/injectable.dart';

import 'login_data_source.dart';

@Injectable(as: LoginDataSource)
class LoginDataSourceImp implements LoginDataSource {
  NetworkService networkService;
  LoginDataSourceImp(this.networkService);

  @override
  Future<Response<dynamic>> login({
    required String identity,
    required String password,
  })  {
    return networkService.dio.post(
      "/auth/login",
      data: {
        "identity": identity,
        "password": password,
      },
    );
  }
}
