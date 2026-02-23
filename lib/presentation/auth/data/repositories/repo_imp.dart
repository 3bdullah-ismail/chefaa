import 'package:chefaa/presentation/auth/data/data_sources/data_source.dart';
import 'package:chefaa/presentation/auth/data/models/reset_password_response.dart';
import 'package:chefaa/presentation/auth/data/repositories/repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error_handling/error_handler.dart';

@Injectable(as: AuthRepo)
class AuthRepoImp implements AuthRepo {
  AuthDataSource authDataSource;
  AuthRepoImp(this.authDataSource);
  @override
  Future<ResetPasswordResponse> forgotPass({required String identity}) async {
    try {
      var response = await authDataSource.forgotPass(identity: identity);
      if (response.statusCode == 200) {
        ResetPasswordResponse data = ResetPasswordResponse.fromJson(
          response.data,
        );
        return data;
      } else {
        var error = ErrorHandler.fromJson(response.data);
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
      if (response.statusCode == 200) {
        ResetPasswordResponse data = ResetPasswordResponse.fromJson(
          response.data,
        );
        return data;
      } else {
        var error = ErrorHandler.fromJson(response.data);
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
      if (response.statusCode == 200) {
        ResetPasswordResponse data = ResetPasswordResponse.fromJson(
          response.data,
        );
        return data;
      } else {
        var error = ErrorHandler.fromJson(response.data);
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
