import '../../../../../core/models/auth_response.dart';

abstract class GoogleSignInRepo {
  Future<AuthResponse>googleSignIn(String idToken);
}