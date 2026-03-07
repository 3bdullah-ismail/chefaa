import 'package:chefaa/core/models/auth_response.dart';
import 'package:chefaa/presentation/auth/google_sign_in/data/datasources/googleSignIn_data_source.dart';
import 'package:chefaa/presentation/auth/google_sign_in/data/repositories/googleSignIn_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GoogleSignInRepo)
class GoogleSignInRepoImp implements GoogleSignInRepo {
  GoogleSignInDataSource googleSignInDataSource;
  GoogleSignInRepoImp(this.googleSignInDataSource);

  @override
  Future<AuthResponse> googleSignIn(String idToken) async {
    try {
      var res = await googleSignInDataSource.googleSignIn(idToken);
      return AuthResponse.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
