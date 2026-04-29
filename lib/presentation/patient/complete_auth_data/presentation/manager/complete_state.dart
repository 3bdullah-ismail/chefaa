part of 'complete_cubit.dart';

enum CompleteStatus { initial, loading, success, error }

class CompleteState {
  final CompleteStatus status;
  final double? weight;
  final int? height;
  final String? bloodType;
  final String? gender;
  final DateTime? birthDate;
  final List<String> chronicDiseases;
  final List<String> allergies;
  final String? message;
  final PatientUpdate? patient;

  const CompleteState({
    this.status = CompleteStatus.initial,
    this.weight,
    this.height,
    this.bloodType,
    this.gender,
    this.birthDate,
    this.chronicDiseases = const [],
    this.allergies = const [],
    this.message,
    this.patient,
  });

  CompleteState copyWith({
    CompleteStatus? status,
    double? weight,
    int? height,
    String? bloodType,
    String? gender,
    DateTime? birthDate,
    List<String>? chronicDiseases,
    List<String>? allergies,
    String? message,
    PatientUpdate? patient,
  }) {
    return CompleteState(
      status: status ?? this.status,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bloodType: bloodType ?? this.bloodType,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      chronicDiseases: chronicDiseases ?? this.chronicDiseases,
      allergies: allergies ?? this.allergies,
      message: message,
      patient: patient ?? this.patient,
    );
  }

  bool get isStep1Complete =>
      weight != null &&
      height != null &&
      bloodType != null &&
      bloodType!.isNotEmpty &&
      gender != null &&
      gender!.isNotEmpty &&
      birthDate != null;
}
