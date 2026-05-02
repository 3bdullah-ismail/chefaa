part of 'complete_cubit.dart';

enum CompleteStatus { initial, loading, success, error }

class CompleteState {
  final CompleteStatus status;
  final double? weight;
  final int? height;
  final String? bloodType;
  final String? gender;
  final DateTime? birthDate;
  final List<String> chronicConditions;
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
    this.chronicConditions = const [],
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
    List<String>? chronicConditions,
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
      chronicConditions: chronicConditions ?? this.chronicConditions,
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
