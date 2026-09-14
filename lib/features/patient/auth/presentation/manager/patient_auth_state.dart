import 'package:chefaa/features/auth/data/models/auth_response.dart';

sealed class PatientAuthState {}

final class PatientInitial extends PatientAuthState {}

final class SignUpSuccessState extends PatientAuthState {
  final String? message;
  final User? patient;

  SignUpSuccessState({this.message, this.patient});
}

final class SignUpErrorState extends PatientAuthState {
  final String message;

  SignUpErrorState(this.message);
}

final class SignUpLoadingState extends PatientAuthState {}
