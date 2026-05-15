import 'package:chefaa/presentation/doctor/layout/home/data/models/Clinics.dart';

import '../../data/models/Clinic.dart';

sealed class ClinicState{}
final class ClinicInitialState extends ClinicState{}
final class ClinicLoadingState extends ClinicState{}
final class ClinicSuccessState extends ClinicState{
  final Clinic clinic;
  ClinicSuccessState({required this.clinic});
}
final class ClinicErrorState extends ClinicState{
  final String message;
  ClinicErrorState({required this.message});   }


// clinics
final class ClinicsSuccessState extends ClinicState{
  final List<Clinics> clinics;
  ClinicsSuccessState({required this.clinics});
}
