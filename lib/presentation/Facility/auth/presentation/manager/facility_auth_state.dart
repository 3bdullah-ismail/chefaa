part of 'facility_auth_cubit.dart';

@immutable
sealed class FacilityAuthState {}

final class FacilityAuthInitial extends FacilityAuthState {}

final class SignUpLoading extends FacilityAuthState {}

final class SingUpSuccess extends FacilityAuthState {
  final String userName;

  SingUpSuccess({required this.userName});
}

final class SingUpFailure extends FacilityAuthState {
  final String errorMessage;

  SingUpFailure(this.errorMessage);
}
