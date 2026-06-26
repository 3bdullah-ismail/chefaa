part of 'pharmacy_profile_cubit.dart';

sealed class PharmacyProfileState {}

final class PharmacyProfileInitial extends PharmacyProfileState {}

final class PharmacyProfileLoading extends PharmacyProfileState {}

final class PharmacyProfileSuccess extends PharmacyProfileState {
  final PharmacyProfileResponse profileResponse;

  PharmacyProfileSuccess(this.profileResponse);
}

final class PharmacyProfileError extends PharmacyProfileState {
  final String errorMessage;

  PharmacyProfileError(this.errorMessage);
}

final class PharmacyProfileUpdateLoading extends PharmacyProfileState {}

final class PharmacyProfileUpdateSuccess extends PharmacyProfileState {
  final PharmacyProfileResponse profileResponse;

  PharmacyProfileUpdateSuccess(this.profileResponse);
}

final class PharmacyProfileUpdateError extends PharmacyProfileState {
  final String errorMessage;

  PharmacyProfileUpdateError(this.errorMessage);
}
