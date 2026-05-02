import 'package:chefaa/presentation/patient/layout/home/patient_medication/data/models/Confirm_medication.dart';

import '../../data/models/Medication_list.dart';
import '../../data/models/Medication_response.dart';

sealed class MedicationState {}
final class MedicationInitialState extends MedicationState {}

// States for adding medication
final class MedicationAdditionLoadingState extends MedicationState {}
final class MedicationAdditionSuccessState extends MedicationState {
  final MedicationResponse medicationResponse;
  MedicationAdditionSuccessState({required this.medicationResponse});
}
final class MedicationAdditionErrorState extends MedicationState {
  final String errorMessage;
  MedicationAdditionErrorState({required this.errorMessage});
}

// States for deleting medication
final class MedicationDeleteLoadingState extends MedicationState {}
final class MedicationDeleteSuccessState extends MedicationState {
  final MedicationResponse medicationResponse;
  MedicationDeleteSuccessState({required this.medicationResponse});
}
final class MedicationDeleteErrorState extends MedicationState {
  final String errorMessage;
  MedicationDeleteErrorState({required this.errorMessage});
}

// States for confirming medication
final class MedicationConfirmLoadingState extends MedicationState {}
final class MedicationConfirmSuccessState extends MedicationState {
  final ConfirmMedication confirmMedication;
  MedicationConfirmSuccessState({required this.confirmMedication});
}
final class MedicationConfirmErrorState extends MedicationState {
  final String errorMessage;
  MedicationConfirmErrorState({required this.errorMessage});
}

// States for updating medication
final class MedicationUpdateLoadingState extends MedicationState {}
final class MedicationUpdateSuccessState extends MedicationState {
  final MedicationResponse medicationResponse;
  MedicationUpdateSuccessState({required this.medicationResponse});
}
final class MedicationUpdateErrorState extends MedicationState {
  final String errorMessage;
  MedicationUpdateErrorState({required this.errorMessage});
}

// State for fetching medication list
final class MedicationListLoadingState extends MedicationState {}
final class MedicationListSuccessState extends MedicationState {
  final MedicationList medications;
  MedicationListSuccessState({required this.medications});
}
final class MedicationListErrorState extends MedicationState {
  final String errorMessage;
  MedicationListErrorState({required this.errorMessage});
}


