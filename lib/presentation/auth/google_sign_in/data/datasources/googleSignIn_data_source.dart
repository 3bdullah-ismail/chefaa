import 'package:dio/dio.dart';

abstract class GoogleSignInDataSource {
  Future<Response>googleSignIn(String idToken);
}