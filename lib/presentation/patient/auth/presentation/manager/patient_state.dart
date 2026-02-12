import '../../data/models/patient.dart';

sealed class PatientState {}
final class PatientInitial extends PatientState{}
final class SignUpSuccessState extends PatientState{
  final String? message;
  final Patient? patient;
  SignUpSuccessState({this.message,this.patient});
}
final class SignUpErrorState extends PatientState{
  final String message;
  SignUpErrorState(this.message);
}
final class SignUpLoadingState extends PatientState{}

