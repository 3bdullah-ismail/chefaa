import 'package:chefaa/presentation/auth/data/models/reset_password_response.dart';

abstract class AuthRepo {
  Future<ResetPasswordResponse> forgotPass({required String identity});
  Future<ResetPasswordResponse> resetCode({
    required String code,
    required String identity,
  });
  Future<ResetPasswordResponse> resetPass({
    required String identity,
    required String code,
    required String newPassword,
  });
}
