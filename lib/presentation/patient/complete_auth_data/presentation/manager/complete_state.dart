part of 'complete_cubit.dart';

@immutable
sealed class CompleteState {}

final class CompleteInitial extends CompleteState {}

final class CompleteLoadingState extends CompleteState {}

final class CompleteSuccessState extends CompleteState {
  final String? message;
  final PatientUpdate? patient;

  CompleteSuccessState({this.message, this.patient});
}

final class CompleteErrorState extends CompleteState {
  final String? message;

  CompleteErrorState(this.message);
}
