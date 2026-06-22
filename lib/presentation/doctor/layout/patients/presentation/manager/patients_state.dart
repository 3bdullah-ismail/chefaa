import 'package:chefaa/presentation/doctor/layout/patients/data/models/complete/Complete_appointment.dart';
import 'package:chefaa/presentation/doctor/layout/patients/data/models/patients/Prescription.dart';

import '../../data/models/Data.dart';

sealed class PatientsState {}

class PatientsInitialState extends PatientsState {}

class PatientsLoadingState extends PatientsState {}

class PatientsSuccessState extends PatientsState {
  final List<Data> upcoming;
  final List<Data> completed;
  final int selectedIndex;

  PatientsSuccessState({
    required this.upcoming,
    required this.completed,
    this.selectedIndex = 0,
  });

  List<Data> get currentList => selectedIndex == 0 ? upcoming : completed;

  PatientsSuccessState copyWith({
    List<Data>? upcoming,
    List<Data>? completed,
    int? selectedIndex,
  }) {
    return PatientsSuccessState(
      upcoming: upcoming ?? this.upcoming,
      completed: completed ?? this.completed,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

class PatientsFailureState extends PatientsState {
  final String errorMessage;

  PatientsFailureState(this.errorMessage);
}

class PrescriptionCreatingLoadingState extends PatientsState {}

class PrescriptionCreatingSuccessState extends PatientsState {
  final Prescription prescription;

  PrescriptionCreatingSuccessState({required this.prescription});
}

class PrescriptionCreatingErrorState extends PatientsState {
  final String errorMessage;

  PrescriptionCreatingErrorState(this.errorMessage);
}

class PrescriptionEditingLoadingState extends PatientsState {}

class PrescriptionEditingSuccessState extends PatientsState {
  final Prescription prescription;

  PrescriptionEditingSuccessState({required this.prescription});
}

class PrescriptionEditingErrorState extends PatientsState {
  final String errorMessage;

  PrescriptionEditingErrorState(this.errorMessage);
}

class PrescriptionPreviousLoadingState extends PatientsState {}

class PrescriptionPreviousSuccessState extends PatientsState {
  final List<Prescription> prescriptions;

  PrescriptionPreviousSuccessState({required this.prescriptions});
}

class PrescriptionPreviousErrorState extends PatientsState {
  final String errorMessage;

  PrescriptionPreviousErrorState(this.errorMessage);
}

class PrescriptionByAppointmentLoadingState extends PatientsState {}

class PrescriptionByAppointmentSuccessState extends PatientsState {
  final Prescription prescription;

  PrescriptionByAppointmentSuccessState({required this.prescription});
}

class PrescriptionByAppointmentErrorState extends PatientsState {
  final String errorMessage;

  PrescriptionByAppointmentErrorState(this.errorMessage);
}

class CompleteAppointmentLoadingState extends PatientsState {}

class CompleteAppointmentSuccessState extends PatientsState {
  final CompleteAppointment appointment;

  CompleteAppointmentSuccessState({required this.appointment});
}

class CompleteAppointmentErrorState extends PatientsState {
  final String errorMessage;

  CompleteAppointmentErrorState(this.errorMessage);
}

class AddMedicineState extends PatientsState {}

class RemoveMedicineState extends PatientsState {}

class PrescriptionFormResetState extends PatientsState {}
