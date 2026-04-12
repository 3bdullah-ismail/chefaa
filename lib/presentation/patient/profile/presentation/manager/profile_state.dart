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
