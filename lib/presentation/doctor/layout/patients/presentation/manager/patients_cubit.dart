import 'package:chefaa/presentation/doctor/layout/patients/data/repositories/patients_repo.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/manager/patients_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PatientsCubit extends Cubit<PatientsState> {
  final PatientsRepo patientsRepo;

  PatientsCubit(this.patientsRepo) : super(PatientsInitialState());

  static PatientsCubit get(context) => BlocProvider.of(context);

  TextEditingController diagnosisController = TextEditingController();
  TextEditingController nextVisitController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController labTestController = TextEditingController();
  TextEditingController imagingController = TextEditingController();

  List<MedicationItem> medications = [MedicationItem()];

  void initPrescriptionForm({
    String diagnosis = '',
    String nextVisit = '',
    String notes = '',
    String labTests = '',
    String imaging = '',
    List<Map<String, String>>? existingMedicines,
  }) {
    _disposeFormControllers();

    diagnosisController = TextEditingController(text: diagnosis);
    nextVisitController = TextEditingController(text: nextVisit);
    notesController = TextEditingController(text: notes);
    labTestController = TextEditingController(text: labTests);
    imagingController = TextEditingController(text: imaging);

    if (existingMedicines != null && existingMedicines.isNotEmpty) {
      medications = existingMedicines
          .map(
            (m) => MedicationItem(
              name: m['name'],
              dosage: m['dosage'],
              frequency: m['frequency'],
              duration: m['duration'],
              instructions: m['instructions'],
            ),
          )
          .toList();
    } else {
      medications = [MedicationItem()];
    }

    emit(PrescriptionFormResetState());
  }

  void _disposeFormControllers() {
    diagnosisController.dispose();
    nextVisitController.dispose();
    notesController.dispose();
    labTestController.dispose();
    imagingController.dispose();

    for (final medicine in medications) {
      medicine.dispose();
    }
  }

  void addMedicine() {
    medications.add(MedicationItem());
    emit(AddMedicineState());
  }

  void removeMedicine(int index) {
    if (index < 0 || index >= medications.length) return;
    if (medications.length <= 1) return;

    medications[index].dispose();
    medications.removeAt(index);

    emit(RemoveMedicineState());
  }


  Future<void> getPatients() async {
    emit(PatientsLoadingState());

    try {
      final patients = await patientsRepo.getPatients();

      final upcoming = patients.where((e) => e.status == "upcoming").toList();

      final completed = patients
          .where((e) => e.status == "completed" && e.paymentStatus == "paid")
          .toList();

      emit(PatientsSuccessState(upcoming: upcoming, completed: completed));
    } catch (e) {
      emit(PatientsFailureState(e.toString()));
    }
  }

  void changeTab(int index) {
    final currentState = state;

    if (currentState is PatientsSuccessState) {
      emit(currentState.copyWith(selectedIndex: index));
    }
  }


  Map<String, dynamic> _medicineToMap(MedicationItem medicine) => {
    "name": medicine.nameController.text,
    "dosage": medicine.dosageController.text,
    "frequency": medicine.frequencyController.text,
    "duration": medicine.durationController.text,
    "instructions": medicine.instructionsController.text,
  };

  List<String> _splitLines(String text) =>
      text.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

  Future<void> createPrescription({required String appointmentId}) async {
    emit(PrescriptionCreatingLoadingState());

    try {
      final prescription = await patientsRepo.createPrescription(
        appointment: appointmentId,
        diagnosis: diagnosisController.text,
        medicines: medications.map(_medicineToMap).toList(),
        labTests: _splitLines(labTestController.text),
        imaging: _splitLines(imagingController.text),
        nextVisit: nextVisitController.text,
        notes: notesController.text,
      );

      emit(PrescriptionCreatingSuccessState(prescription: prescription));
    } catch (e) {
      emit(PrescriptionCreatingErrorState(e.toString()));
    }
  }

  Future<void> updatePrescription({required String appointmentId}) async {
    emit(PrescriptionEditingLoadingState());

    try {
      final prescription = await patientsRepo.editPrescription(
        appointment: appointmentId,
        diagnosis: diagnosisController.text,
        medicines: medications.map(_medicineToMap).toList(),
        labTests: _splitLines(labTestController.text),
        imaging: _splitLines(imagingController.text),
        nextVisit: nextVisitController.text,
        notes: notesController.text,
      );

      emit(PrescriptionEditingSuccessState(prescription: prescription));
    } catch (e) {
      emit(PrescriptionEditingErrorState(e.toString()));
    }
  }

  Future<void> getPrescriptionByAppointment({
    required String appointmentId,
  }) async {
    emit(PrescriptionByAppointmentLoadingState());

    try {
      final prescription = await patientsRepo.getPrescriptionByAppointment(
        appointmentId: appointmentId,
      );

      emit(PrescriptionByAppointmentSuccessState(prescription: prescription));
    } catch (e) {
      emit(PrescriptionByAppointmentErrorState(e.toString()));
    }
  }

  Future<void> getPreviousPrescriptions({required String appointmentId}) async {
    emit(PrescriptionPreviousLoadingState());

    try {
      final prescriptions = await patientsRepo.getPreviousPrescriptions(
        appointmentId: appointmentId,
      );

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
    } catch (e) {
      emit(CompleteAppointmentErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _disposeFormControllers();
    return super.close();
  }
}

class MedicationItem {
  final TextEditingController nameController;
  final TextEditingController dosageController;
  final TextEditingController frequencyController;
  final TextEditingController durationController;
  final TextEditingController instructionsController;

  MedicationItem({
    String? name,
    String? dosage,
    String? frequency,
    String? duration,
    String? instructions,
  }) : nameController = TextEditingController(text: name ?? ''),
       dosageController = TextEditingController(text: dosage ?? ''),
       frequencyController = TextEditingController(text: frequency ?? ''),
       durationController = TextEditingController(text: duration ?? ''),
       instructionsController = TextEditingController(text: instructions ?? '');

  void dispose() {
    nameController.dispose();
    dosageController.dispose();
    frequencyController.dispose();
    durationController.dispose();
    instructionsController.dispose();
  }
}
