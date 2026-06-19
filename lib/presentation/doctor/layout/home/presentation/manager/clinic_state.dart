import 'package:chefaa/presentation/doctor/layout/home/data/models/Clinics.dart';

import '../../data/models/Clinic.dart';

sealed class ClinicState {}

final class ClinicInitialState extends ClinicState {}

final class ClinicAddedLoadingState extends ClinicState {}

final class ClinicAddedSuccessState extends ClinicState {
  ClinicAddedSuccessState();
}

final class ClinicAddedErrorState extends ClinicState {
  final String message;

  ClinicAddedErrorState({required this.message});
}

// clinics
final class ClinicsLoadingState extends ClinicState {}
final class ClinicsErrorState extends ClinicState {
  final String message;

  ClinicsErrorState({required this.message});
}
final class ClinicsSuccessState extends ClinicState {
  final List<Clinics> clinics;

  ClinicsSuccessState({required this.clinics});
}

// edit
final class ClinicEditLoadingState extends ClinicState {}
final class ClinicEditSuccessState extends ClinicState {
  final Clinic clinic;
  ClinicEditSuccessState({required this.clinic});
}
final class ClinicEditErrorState extends ClinicState {
  final String message;
  ClinicEditErrorState({required this.message});
}


// delete
final class ClinicDeleteLoadingState extends ClinicState {}
final class ClinicDeleteSuccessState extends ClinicState {
  final String clinicID;
  ClinicDeleteSuccessState({required this.clinicID});
}
final class ClinicDeleteErrorState extends ClinicState {
  final String message;
  ClinicDeleteErrorState({required this.message});
}
// get by id
final class ClinicLoadingState extends ClinicState {}
final class ClinicSuccessState extends ClinicState {
  final Clinic clinic;
  ClinicSuccessState({required this.clinic});
}
final class ClinicErrorState extends ClinicState {
  final String message;
  ClinicErrorState({required this.message});
}