import 'package:chefaa/presentation/patient/complete_auth_data/data/repositories/complete_patient_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/patient.dart';

part 'complete_state.dart';

@injectable
class CompleteCubit extends Cubit<CompleteState> {
  final CompletePatientRepo completePatientRepo;

  CompleteCubit(this.completePatientRepo) : super(const CompleteState());

  static CompleteCubit get(BuildContext context) =>
      BlocProvider.of<CompleteCubit>(context);

  void updateGender(String? gender) {
    emit(
      state.copyWith(
        status: CompleteStatus.initial,
        gender: gender,
        message: null,
      ),
    );
  }

  void updateBirthDate(DateTime? birthDate) {
    emit(
      state.copyWith(
        status: CompleteStatus.initial,
        birthDate: birthDate,
        message: null,
      ),
    );
  }

  String? captureBasicInfo({
    required String weightText,
    required String heightText,
    required String bloodTypeText,
  }) {
    final weight = double.tryParse(weightText.trim());
    if (weight == null) {
      return 'Please enter a valid weight';
    }

    final height = int.tryParse(heightText.trim());
    if (height == null) {
      return 'Please enter a valid height';
    }

    if (state.gender == null || state.gender!.isEmpty) {
      return 'Please select your gender';
    }

    if (state.birthDate == null) {
      return 'Please select your date of birth';
    }

    final bloodType = bloodTypeText.trim();
    if (bloodType.isEmpty) {
      return 'Please enter your blood type';
    }

    emit(
      state.copyWith(
        status: CompleteStatus.initial,
        weight: weight,
        height: height,
        bloodType: bloodType,
        message: null,
      ),
    );

    return null;
  }

  void toggleChronicDisease(String disease) {
    final updated = List<String>.from(state.chronicDiseases);
    if (updated.contains(disease)) {
      updated.remove(disease);
    } else {
      updated.add(disease);
    }
    emit(
      state.copyWith(
        status: CompleteStatus.initial,
        chronicDiseases: updated,
        message: null,
      ),
    );
  }

  void addCustomChronicDisease(String input) {
    final value = input.trim();
    if (value.isEmpty) return;

    final updated = List<String>.from(state.chronicDiseases);
    if (!updated.contains(value)) {
      updated.add(value);
      emit(
        state.copyWith(
          status: CompleteStatus.initial,
          chronicDiseases: updated,
          message: null,
        ),
      );
    }
  }

  void toggleAllergy(String allergy) {
    final updated = List<String>.from(state.allergies);
    if (updated.contains(allergy)) {
      updated.remove(allergy);
    } else {
      updated.add(allergy);
    }
    emit(
      state.copyWith(
        status: CompleteStatus.initial,
        allergies: updated,
        message: null,
      ),
    );
  }

  void addCustomAllergy(String input) {
    final value = input.trim();
    if (value.isEmpty) return;

    final updated = List<String>.from(state.allergies);
    if (!updated.contains(value)) {
      updated.add(value);
      emit(
        state.copyWith(
          status: CompleteStatus.initial,
          allergies: updated,
          message: null,
        ),
      );
    }
  }

  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> completeSignUp() async {
    if (!state.isStep1Complete) {
      emit(
        state.copyWith(
          status: CompleteStatus.error,
          message: 'Please complete your basic information first',
        ),
      );
      return;
    }

    emit(state.copyWith(status: CompleteStatus.loading, message: null));
    try {
      final age = calculateAge(state.birthDate!);

      final response = await completePatientRepo.completeSignUp(
        weight: state.weight!,
        height: state.height!,
        bloodType: state.bloodType!,
        gender: state.gender?.toLowerCase(),
        age: age,
        chronicDiseases: state.chronicDiseases,
        allergies: state.allergies,
      );

      emit(
        state.copyWith(
          status: CompleteStatus.success,
          message: response.message,
          patient: response.patient,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: CompleteStatus.error, message: e.toString()));
    }
  }

  void reset() {
    emit(const CompleteState());
  }
}
