part of 'doctor_auth_cubit.dart';

@immutable
sealed class DoctorAuthState {}

final class DoctorAuthInitial extends DoctorAuthState {}

final class SingUpLoading extends DoctorAuthState {}

final class SingUpSuccess extends DoctorAuthState {
  final String userName;

  SingUpSuccess({required this.userName});
}

final class SingUpFailure extends DoctorAuthState {
  final String errorMessage;

  SingUpFailure(this.errorMessage);
}

class UploadMembershipState extends DoctorAuthState {
  final PlatformFile? file;

  UploadMembershipState({this.file});
}
