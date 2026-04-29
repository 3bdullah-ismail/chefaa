part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetProfileDataSuccessState extends ProfileState {
  final UserProfileEntity profileData;

  GetProfileDataSuccessState(this.profileData);
}

final class GetProfileDataFailureState extends ProfileState {
  final String message;

  GetProfileDataFailureState(this.message);
}

final class GetProfileDataLoadingState extends ProfileState {}

final class UpdateProfileDataLoadingState extends ProfileState {}

final class UpdateProfileDataSuccessState extends ProfileState {
  final UserProfileEntity profileData;

  UpdateProfileDataSuccessState(this.profileData);
}

final class UpdateProfileDataFailureState extends ProfileState {
  final String message;

  UpdateProfileDataFailureState(this.message);
}

final class UpdateMedicalInformationLoadingState extends ProfileState {}

final class UpdateMedicalInformationSuccessState extends ProfileState {
  final UserProfileEntity profileData;

  UpdateMedicalInformationSuccessState(this.profileData);
}

final class UpdateMedicalInformationFailureState extends ProfileState {
  final String message;

  UpdateMedicalInformationFailureState(this.message);
}
