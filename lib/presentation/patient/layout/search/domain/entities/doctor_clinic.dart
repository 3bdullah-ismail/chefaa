import '../../data/models/Clinics.dart';
import '../../data/models/UserId.dart';

class DoctorClinic {
  final UserId? user;
  final String specialization;
  final String gender;
  final List<Clinics> clinics;

  DoctorClinic({
    this.user,
    required this.specialization,
    required this.gender,
    required this.clinics,
  });

  factory DoctorClinic.fromJson(Map<String, dynamic> json) {
    return DoctorClinic(
      user: json['userId'] != null
          ? UserId.fromJson(json['userId'])
          : null,
      specialization: json['specialization'] ?? '',
      gender: json['gender'] ?? '',
      clinics: (json['clinics'] as List<dynamic>?)
          ?.map((e) => Clinics.fromJson(e))
          .toList() ??
          [],
    );
  }
}