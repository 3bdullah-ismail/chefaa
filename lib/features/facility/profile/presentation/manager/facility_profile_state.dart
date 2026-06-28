part of 'facility_profile_cubit.dart';

@immutable
sealed class FacilityProfileState {}

final class FacilityProfileInitial extends FacilityProfileState {}

final class GetProfileLoading extends FacilityProfileState {}

final class GetProfileSuccess extends FacilityProfileState {
  final GetProfileResponse response;

  GetProfileSuccess(this.response);
}

final class GetProfileFailure extends FacilityProfileState {
  final String errorMessage;

  GetProfileFailure(this.errorMessage);
}

final class UpdateProfileLoading extends FacilityProfileState {}

final class UpdateProfileSuccess extends FacilityProfileState {
  final GetProfileResponse response;

  UpdateProfileSuccess(this.response);
}

final class UpdateProfileFailure extends FacilityProfileState {
  final String errorMessage;

  UpdateProfileFailure(this.errorMessage);
}
