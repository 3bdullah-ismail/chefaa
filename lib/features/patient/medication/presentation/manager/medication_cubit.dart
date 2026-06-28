import 'package:chefaa/features/patient/medication/domain/repositories/medication_repo.dart';
import 'package:chefaa/features/patient/medication/presentation/manager/medication_state.dart';
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
      if (!isClosed) emit(MedicationAdditionLoadingState());

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
      if (!isClosed) {
        emit(
        MedicationAdditionSuccessState(medicationResponse: medicationResponse),
      );
      }
    } catch (e) {
      if (!isClosed) emit(MedicationAdditionErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getMedicationList({bool forceRefresh = false}) async {
    if (_isMedicationListLoading) return;
    if (_hasLoadedMedicationList && !forceRefresh) return;

    _isMedicationListLoading = true;
      if (!isClosed) emit(MedicationListLoadingState());

    try {
      final medicationList = await medicationRepo.getMedicationList();
      _hasLoadedMedicationList = true;
      if (!isClosed) emit(MedicationListSuccessState(medications: medicationList));
    } catch (e) {
      if (!isClosed) emit(MedicationListErrorState(errorMessage: e.toString()));
    } finally {
      _isMedicationListLoading = false;
    }
  }

  Future<void> updateMedication({required String medicationId}) async {
      if (!isClosed) emit(MedicationUpdateLoadingState());

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
      if (!isClosed) {
        emit(
        MedicationUpdateSuccessState(medicationResponse: medicationResponse),
      );
      }
    } catch (e) {
      if (!isClosed) emit(MedicationUpdateErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> deleteMedication(String medicationId) async {
      if (!isClosed) emit(MedicationDeleteLoadingState());

    try {
      final medicationResponse = await medicationRepo.deleteMedication(
        medicationId,
      );
      if (!isClosed) {
        emit(
        MedicationDeleteSuccessState(medicationResponse: medicationResponse),
      );
      }
    } catch (e) {
      if (!isClosed) emit(MedicationDeleteErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> confirmMedication(String medicationId) async {
      if (!isClosed) emit(MedicationConfirmLoadingState());

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
      if (!isClosed) {
        emit(
          MedicationListSuccessState(
            medications: currentState.medications.copyWith(
              medications: updatedMedications,
            ),
          ),
        );
      }
      }
      if (!isClosed) emit(MedicationConfirmSuccessState(confirmMedication: confirmResult));
    } catch (e) {
      if (!isClosed) emit(MedicationConfirmErrorState(errorMessage: e.toString()));
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
      if (!isClosed) emit(MedicationInitialState());
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
