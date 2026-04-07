import 'package:chefaa/presentation/auth/data/repositories/repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error_handling/failure.dart';
import '../../../../core/models/auth_response.dart';
import '../../../../core/services/storage_service.dart';
import '../data_sources/data_source.dart';
import '../models/reset_password_response.dart';

@Injectable(as: AuthRepo)
class AuthRepoImp implements AuthRepo {
  final AuthDataSource authDataSource;
  AuthRepoImp(this.authDataSource);
  @override
  Future<AuthResponse> login({
    required String identity,
    required String password,
  }) async {
    try {
      var res = await authDataSource.login(
        identity: identity,
        password: password,
      );
      AuthResponse data = AuthResponse.fromJson(res.data);
      await StorageService.saveToken(data.accessToken!);
      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<AuthResponse> googleSignIn(String idToken) async {
    try {
      var res = await authDataSource.googleSignIn(idToken);
      return AuthResponse.fromJson(res.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw 'Social login failed';
    }
  }

  @override
  Future<ResetPasswordResponse> forgotPass({required String identity}) async {
    try {
      var response = await authDataSource.forgotPass(identity: identity);
      return ResetPasswordResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<ResetPasswordResponse> resetCode({
    required String code,
    required String identity,
  }) async {
    try {
      var response = await authDataSource.resetCode(
        code: code,
        identity: identity,
      );
      return ResetPasswordResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }

  @override
  Future<ResetPasswordResponse> resetPass({
    required String identity,
    required String code,
    required String newPassword,
  }) async {
    try {
      var response = await authDataSource.resetPass(
        newPassword: newPassword,
        identity: identity,
        code: code,
      );
      return ResetPasswordResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw ServerFailure.unexpectedError;
    }
  }
}
