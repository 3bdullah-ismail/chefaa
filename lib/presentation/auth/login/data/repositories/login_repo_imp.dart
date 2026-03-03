import 'package:chefaa/core/models/auth_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';


import '../../../../../core/error_handling/error_handler.dart';
import '../../../../../core/services/storage_service.dart';
import '../data_source/login_data_source.dart';
import 'login_repo.dart';

@Injectable(as: LoginRepo)
class LoginRepoImp implements LoginRepo {
  LoginDataSource loginDataSource;
  LoginRepoImp(this.loginDataSource);

  @override
  Future<AuthResponse> login({
    required String identity,
    required String password,
  }) async {
   try {
     var res = await loginDataSource.login(
       identity: identity,
       password: password,
     );
     if (res.statusCode == 200) {
       AuthResponse data = AuthResponse.fromJson(res.data);

       await StorageService.saveToken(data.accessToken!);

       return data;
     } else {
       var error = ErrorHandler.fromJson(res.data);
       throw error.message ?? "";
     }
   } on DioException catch (e, s) {
     print(s);
     var error = ErrorHandler.fromJson(e.response?.data);
     throw error.message ?? "";
   } catch (e, s) {
     print(e);
     print(s);
     rethrow;
   }

  }
}
