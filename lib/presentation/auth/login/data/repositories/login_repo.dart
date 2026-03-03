import 'package:chefaa/core/models/auth_response.dart';

abstract class LoginRepo {
  Future<AuthResponse> login({
    required String identity,
    required String password,
  });
}
