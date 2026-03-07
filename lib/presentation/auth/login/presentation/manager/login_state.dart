import '../../../../../core/models/auth_response.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final User user;
  final String message;

  LoginSuccessState({required this.user, required this.message});
}

final class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
}
