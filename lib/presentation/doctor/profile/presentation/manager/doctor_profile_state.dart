part of 'doctor_profile_cubit.dart';

@immutable
sealed class DoctorProfileState {}

final class DoctorProfileInitial extends DoctorProfileState {}

final class DoctorProfileControllersInitializedState
    extends DoctorProfileState {}

final class DoctorProfileUIUpdatedState extends DoctorProfileState {}

final class GetDoctorDataLoadingState extends DoctorProfileState {}

final class GetDoctorDataSuccessState extends DoctorProfileState {
  final DoctorProfileEntity doctorProfileEntity;

  GetDoctorDataSuccessState(this.doctorProfileEntity);
}

final class GetDoctorDataErrorState extends DoctorProfileState {
  final String message;

  GetDoctorDataErrorState(this.message);
}

final class UpdateDoctorDataLoadingState extends DoctorProfileState {}

final class UpdateDoctorDataSuccessState extends DoctorProfileState {
  final DoctorProfileEntity doctorProfileEntity;

  UpdateDoctorDataSuccessState(this.doctorProfileEntity);
}

final class UpdateDoctorDataErrorState extends DoctorProfileState {
  final String message;

  UpdateDoctorDataErrorState(this.message);
}
