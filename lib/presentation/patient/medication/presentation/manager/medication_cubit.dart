import 'package:chefaa/presentation/patient/medication/data/repositories/medication_repo.dart';
import 'package:chefaa/presentation/patient/medication/presentation/manager/medication_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MedicationCubit extends Cubit<MedicationState> {
  final MedicationRepo medicationRepo;

  MedicationCubit(this.medicationRepo) : super(MedicationInitialState());

  static MedicationCubit get(BuildContext context) =>
      BlocProvider.of<MedicationCubit>(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController formController = TextEditingController();
  TextEditingController timesPerDayController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  bool isActive = false;
  bool _isMedicationListLoading = false;
  bool _hasLoadedMedicationList = false;

  int timesPerDay = 1;

  void setTimesPerDay(String value) {
    timesPerDayController.text = value;

    switch (value) {
      case "Once a day (1)":
        timesPerDay = 1;
        break;

      case "Every 12 hours":
        timesPerDay = 2;
        break;

      case "Every 8 hours":
        timesPerDay = 3;
        break;

      case "As needed":
        timesPerDay = 0;
        break;

      default:
        timesPerDay = 1;
    }
  }

  Future<void> addMedication() async {
    emit(MedicationAdditionLoadingState());

    try {
      final medicationResponse = await medicationRepo.addMedication(
        name: nameController.text,
        dosage: "${dosageController.text} mg",
        form: formController.text,
        timesPerDay: timesPerDay,
        schedule: scheduleController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        startDate: startDateController.text,
        endDate: endDateController.text,
        isActive: isActive,
      );

      emit(
        MedicationAdditionSuccessState(medicationResponse: medicationResponse),
      );
    } catch (e) {
      emit(MedicationAdditionErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getMedicationList({bool forceRefresh = false}) async {
    if (_isMedicationListLoading) return;
    if (_hasLoadedMedicationList && !forceRefresh) return;

    _isMedicationListLoading = true;
    emit(MedicationListLoadingState());

    try {
      final medicationList = await medicationRepo.getMedicationList();
      _hasLoadedMedicationList = true;

      emit(MedicationListSuccessState(medications: medicationList));
    } catch (e) {
      emit(MedicationListErrorState(errorMessage: e.toString()));
    } finally {
      _isMedicationListLoading = false;
    }
  }

  Future<void> updateMedication({required String medicationId}) async {
    emit(MedicationUpdateLoadingState());

    try {
      final medicationResponse = await medicationRepo.updateMedication(
        medicationId: medicationId,
        name: nameController.text,
        dosage: "${dosageController.text} mg",
        form: formController.text,
        timesPerDay: timesPerDay,
        schedule: scheduleController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        startDate: startDateController.text,
        endDate: endDateController.text,
        isActive: isActive,
      );

      emit(
        MedicationUpdateSuccessState(medicationResponse: medicationResponse),
      );
    } catch (e) {
      emit(MedicationUpdateErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> deleteMedication(String medicationId) async {
    emit(MedicationDeleteLoadingState());

    try {
      final medicationResponse = await medicationRepo.deleteMedication(
        medicationId,
      );

      emit(
        MedicationDeleteSuccessState(medicationResponse: medicationResponse),
      );
    } catch (e) {
      emit(MedicationDeleteErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> confirmMedication(String medicationId) async {
    emit(MedicationConfirmLoadingState());

    try {
      final confirmResult = await medicationRepo.confirmMedication(
        medicationId,
      );

      final currentState = state;
      if (currentState is MedicationListSuccessState) {
        final updatedMedications = currentState.medications.medications
            ?.map(
              (med) => med.id == medicationId
                  ? med.copyWith(
                      adherencePercentage: num.tryParse(
                        confirmResult.adherenceRate ?? '',
                      ),
                    )
                  : med,
            )
            .toList();

        emit(
          MedicationListSuccessState(
            medications: currentState.medications.copyWith(
              medications: updatedMedications,
            ),
          ),
        );
      }

      emit(MedicationConfirmSuccessState(confirmMedication: confirmResult));
    } catch (e) {
      emit(MedicationConfirmErrorState(errorMessage: e.toString()));
    }
  }

  void clearControllers() {
    nameController.clear();
    dosageController.clear();
    formController.clear();
    timesPerDayController.clear();
    scheduleController.clear();
    startDateController.clear();
    endDateController.clear();

    isActive = false;
    timesPerDay = 1;
  }

  void reset() {
    _hasLoadedMedicationList = false;
    _isMedicationListLoading = false;
    clearControllers();
    emit(MedicationInitialState());
  }

  @override
  Future<void> close() {
    nameController.dispose();
    dosageController.dispose();
    formController.dispose();
    timesPerDayController.dispose();
    scheduleController.dispose();
    startDateController.dispose();
    endDateController.dispose();

    return super.close();
  }
}
