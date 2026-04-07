part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {
  final User user;
  final String message;

  LoginSuccessState({required this.user, required this.message});
}

final class LoginErrorState extends AuthState {
  final String message;

  LoginErrorState(this.message);
}

final class GoogleSignInLoadingState extends AuthState {}

final class GoogleSignInSuccessState extends AuthState {
  final User user;
  final String? message;

  GoogleSignInSuccessState({required this.user, required this.message});
}

final class GoogleSignInErrorState extends AuthState {
  final String? message;

  GoogleSignInErrorState(this.message);
}

final class ForgotPassSuccessState extends AuthState {
  final String? message;

  ForgotPassSuccessState({this.message});
}

final class ForgotPassLoadingState extends AuthState {}

final class ForgotPassErrorState extends AuthState {
  final String? message;

  ForgotPassErrorState({this.message});
}

final class ResetCodeSuccessState extends AuthState {
  final String? message;

  ResetCodeSuccessState({this.message});
}

final class ResetCodeLoadingState extends AuthState {}

final class ResetCodeErrorState extends AuthState {
  final String? message;

  ResetCodeErrorState({this.message});
}

final class ResetPassSuccessState extends AuthState {
  final String? message;

  ResetPassSuccessState({this.message});
}

final class ResetPassLoadingState extends AuthState {}

final class ResetPassErrorState extends AuthState {
  final String? message;

  ResetPassErrorState({this.message});
}
