import 'package:chefaa/presentation/patient/complete_auth_data/data/repositories/complete_patient_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/patient.dart';

part 'complete_state.dart';

@injectable
class CompleteCubit extends Cubit<CompleteState> {
  final CompletePatientRepo completePatientRepo;

  CompleteCubit(this.completePatientRepo) : super(CompleteInitial());

  double? weight;
  int? height;
  String? bloodType;
  String? gender;
  DateTime? birthDate;

  List<String> chronicDiseases = [];

  List<String> allergies = [];

  static CompleteCubit get(context) => BlocProvider.of(context);

  void setBasicInfo({
    required double weight,
    required int height,
    required String bloodType,
    required String? gender,
    required DateTime? birthDate,
  }) {
    this.weight = weight;
    this.height = height;
    this.bloodType = bloodType;
    this.gender = gender;
    this.birthDate = birthDate;
  }

  void setChronicDiseases(List<String> diseases) {
    chronicDiseases = diseases;
  }

  void setAllergies(List<String> allergies) {
    this.allergies = allergies;
  }

  bool get isStep1Completed {
    return weight != null &&
        height != null &&
        bloodType != null &&
        bloodType!.isNotEmpty &&
        birthDate != null;
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
    if (!isStep1Completed) {
      emit(CompleteErrorState("Please complete your basic information first"));
      return;
    }

    emit(CompleteLoadingState());

    try {
      final age = calculateAge(birthDate!);

      final response = await completePatientRepo.completeSignUp(
        weight: weight!,
        height: height!,
        bloodType: bloodType!,
        gender: gender?.toLowerCase(),
        age: age,
        chronicDiseases: chronicDiseases,
        allergies: allergies,
      );

      emit(
        CompleteSuccessState(
          message: response.message,
          patient: response.patient,
        ),
      );
    } catch (e) {
      emit(CompleteErrorState(e.toString()));
    }
  }

  void reset() {
    weight = null;
    height = null;
    bloodType = null;
    gender = null;
    birthDate = null;
    chronicDiseases.clear();
    allergies.clear();
    emit(CompleteInitial());
  }
}
