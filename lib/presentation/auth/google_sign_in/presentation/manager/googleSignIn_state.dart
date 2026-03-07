import '../../../../../core/models/auth_response.dart';

sealed class GoogleSignInState {}

final class GoogleSignInInitial extends GoogleSignInState {}

final class GoogleSignInLoadingState extends GoogleSignInState {}

final class GoogleSignInSuccessState extends GoogleSignInState {
  final User user;
  final String? message;
  GoogleSignInSuccessState({required this.user, required this.message});
}

final class GoogleSignInErrorState extends GoogleSignInState {
  final String? message;
  GoogleSignInErrorState(this.message);
}
