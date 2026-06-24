import 'package:chefaa/presentation/doctor/layout/patients/data/repositories/patients_repo.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/manager/patients_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/Data.dart';
import '../../data/models/patients/Prescription.dart';

@injectable
class PatientsCubit extends Cubit<PatientsState> {
  final PatientsRepo patientsRepo;

  PatientsCubit(this.patientsRepo) : super(PatientsInitialState());

  static PatientsCubit get(context) => BlocProvider.of(context);
  Prescription? currentPrescription;
  List<Prescription> previousPrescriptions = [];
  dynamic selectedAppointment;

  void selectAppointment(dynamic appointment) {
    selectedAppointment = appointment;
  }

  TextEditingController diagnosisController = TextEditingController();
  TextEditingController nextVisitController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController labTestController = TextEditingController();
  TextEditingController imagingController = TextEditingController();

  List<MedicationItem> medications = [MedicationItem()];
  int selectedTab = 0;
  void addMedicine() {
    medications.add(MedicationItem());
    emit(AddMedicineState());
  }

  void removeMedicine(int index) {
    medications[index].dispose();
    medications.removeAt(index);

    emit(RemoveMedicineState());
  }

  List<Data> allPatients = [];
  List<Data> filteredPatients = [];

  Future<void> getPatients() async {
    emit(
      PatientsSuccessState(
        upcoming: [],
        completed: [],
        selectedIndex: 0,
        isUpcomingLoading: true,
        isCompletedLoading: false,
      ),
    );

    try {
      final patients = await patientsRepo.getPatients();

      final upcoming =
      patients.where((e) => e.status == "upcoming").toList();

      final completed =
      patients.where((e) => e.status == "completed").toList();

      emit(
        PatientsSuccessState(
          upcoming: upcoming,
          completed: completed,
          selectedIndex: 0,
          isUpcomingLoading: false,
          isCompletedLoading: false,
        ),
      );

    } catch (e) {
      emit(PatientsFailureState(e.toString()));
    }
  }
  Future<void> refreshCurrentTab() async {
    try {
      final patients = await patientsRepo.getPatients();

      final upcoming =
      patients.where((e) => e.status == "upcoming").toList();

      final completed =
      patients.where((e) => e.status == "completed").toList();

      emit(
        PatientsSuccessState(
          upcoming: upcoming,
          completed: completed,
          selectedIndex: selectedTab,
        ),
      );
    } catch (e) {
      emit(PatientsFailureState(e.toString()));
    }
  }
  void changeTab(int index) {
    selectedTab = index;

    final currentState = state;

    if (currentState is PatientsSuccessState) {
      emit(currentState.copyWith(selectedIndex: index));
    }
  }
  Future<void> createPrescription({required String appointmentId}) async {
    emit(PrescriptionCreatingLoadingState());

    try {
      final prescription = await patientsRepo.createPrescription(
        appointment: appointmentId,

        diagnosis: diagnosisController.text,

        medicines: medications
            .map(
              (medicine) => {
                "name": medicine.nameController.text,
                "dosage": medicine.dosageController.text,
                "frequency": medicine.frequencyController.text,
                "duration": medicine.durationController.text,
                "instructions": medicine.instructionsController.text,
              },
            )
            .toList(),

        labTests: labTestController.text
            .split('\n')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),

        imaging: imagingController.text
            .split('\n')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),

        nextVisit: nextVisitController.text,

        notes: notesController.text,
      );

      currentPrescription = prescription;

      emit(PrescriptionCreatingSuccessState(prescription: prescription));
    } catch (e) {
      emit(PrescriptionCreatingErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    diagnosisController.dispose();
    nextVisitController.dispose();
    notesController.dispose();
    labTestController.dispose();
    imagingController.dispose();

    for (final medicine in medications) {
      medicine.dispose();
    }

    return super.close();
  }

  Future<void> updatePrescription({required String appointmentId}) async {
    emit(PrescriptionEditingLoadingState());

    try {
      final prescription = await patientsRepo.editPrescription(
        appointment: appointmentId,
        diagnosis: diagnosisController.text,

        medicines: medications
            .map(
              (medicine) => {
                "name": medicine.nameController.text,
                "dosage": medicine.dosageController.text,
                "frequency": medicine.frequencyController.text,
                "duration": medicine.durationController.text,
                "instructions": medicine.instructionsController.text,
              },
            )
            .toList(),

        labTests: labTestController.text
            .split('\n')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),

        imaging: imagingController.text
            .split('\n')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),

        nextVisit: nextVisitController.text,

        notes: notesController.text,
      );

      currentPrescription = prescription;

      emit(PrescriptionEditingSuccessState(prescription: prescription));
    } catch (e) {
      emit(PrescriptionEditingErrorState(e.toString()));
    }
  }

  Future<void> getPrescriptionByAppointment({
    required String appointmentId,
  }) async {
    currentPrescription = null;

    emit(PrescriptionByAppointmentLoadingState());

    try {
      currentPrescription = await patientsRepo.getPrescriptionByAppointment(
        appointmentId: appointmentId,
      );

      emit(
        PrescriptionByAppointmentSuccessState(
          prescription: currentPrescription!,
        ),
      );

    } catch (e) {
      currentPrescription = null;

      emit(PrescriptionByAppointmentErrorState(e.toString()));
    }
  }

  Future<void> getPreviousPrescriptions({required String appointmentId}) async {
    emit(PrescriptionPreviousLoadingState());

    try {
      final prescriptions = await patientsRepo.getPreviousPrescriptions(
        appointmentId: appointmentId,
      );
      previousPrescriptions = prescriptions;
      emit(PrescriptionPreviousSuccessState(prescriptions: prescriptions));
    } catch (e) {
      emit(PrescriptionPreviousErrorState(e.toString()));
    }
  }

  Future<void> completeAppointment({required String appointmentId}) async {
    emit(CompleteAppointmentLoadingState());

    try {
      final complete = await patientsRepo.completeAppointment(
        appointmentId: appointmentId,
      );

      emit(CompleteAppointmentSuccessState(appointment: complete));

      await refreshCurrentTab();
    } catch (e) {
      emit(CompleteAppointmentErrorState(e.toString()));
    }
  }

  void clearPrescriptionForm() {
    diagnosisController.clear();
    nextVisitController.clear();
    notesController.clear();
    labTestController.clear();
    imagingController.clear();

    for (final medicine in medications) {
      medicine.dispose();
    }

    medications = [MedicationItem()];
  }
}

class MedicationItem {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController dosageController = TextEditingController();

  final TextEditingController frequencyController = TextEditingController();

  final TextEditingController durationController = TextEditingController();

  final TextEditingController instructionsController = TextEditingController();

  void dispose() {
    nameController.dispose();
    dosageController.dispose();
    frequencyController.dispose();
    durationController.dispose();
    instructionsController.dispose();
  }
}
