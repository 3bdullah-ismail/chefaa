import 'package:chefaa/features/auth/domain/repositories/repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/auth/data/models/auth_response.dart';
import 'package:chefaa/core/services/storage_service.dart';
import 'package:chefaa/features/auth/data/data_sources/data_source.dart';
import 'package:chefaa/features/auth/data/models/reset_password_response.dart';
import 'package:flutter/foundation.dart';

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
      if (data.accessToken != null) {
        await StorageService.saveToken(data.accessToken!);
      }
      return data;
    } on DioException catch (e) {
      throw ServerFailure.fromDioError(e).message;
    } catch (e) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  @override
  Future<AuthResponse> googleSignIn(String idToken) async {
    try {
      debugPrint('AuthRepoImp.googleSignIn calling data source');
      var res = await authDataSource.googleSignIn(idToken);
      debugPrint('AuthRepoImp.googleSignIn response data=${res.data}');
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
      throw 'An unexpected error occurred. Please try again.';
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
      throw 'An unexpected error occurred. Please try again.';
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
      throw 'An unexpected error occurred. Please try again.';
    }
  }
}
