part of 'pharmacy_profile_cubit.dart';

sealed class PharmacyProfileState {}

final class PharmacyProfileInitial extends PharmacyProfileState {}

final class PharmacyProfileLoading extends PharmacyProfileState {}

final class PharmacyProfileSuccess extends PharmacyProfileState {
  final PharmacyProfileModel pharmacyProfile;

  PharmacyProfileSuccess(this.pharmacyProfile);
}

final class PharmacyProfileFailure extends PharmacyProfileState {
  final String message;

  PharmacyProfileFailure(this.message);
}
