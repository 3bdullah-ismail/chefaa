import 'package:hive/hive.dart';

part "clinic_model.g.dart";

@HiveType(typeId: 1)
class ClinicModel {
  @HiveField(0)
  final String doctorName;
  @HiveField(1)
  final String doctorSpecialty;
  @HiveField(2)
  final String doctorRating;
  @HiveField(3)
  final String doctorRatingCount;
  @HiveField(4)
  final String clinicPrice;
  @HiveField(5)
  final String? doctorImageUrl;
  @HiveField(6)
  final String? doctorGender;
  @HiveField(7)
  final String? clinicLocation;
  @HiveField(8)
  final List<DateTime> availableDays;
  @HiveField(9)
  final String clinicId;
  @HiveField(10)
  final String clinicName;

  const ClinicModel({
    required this.doctorName,
    required this.availableDays,
    required this.doctorSpecialty,
    required this.doctorRating,
    required this.doctorRatingCount,
    required this.clinicPrice,
    this.doctorImageUrl,
    this.doctorGender,
    this.clinicLocation,
    required this.clinicId,
    required this.clinicName,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctorName': doctorName,
      'availableDays': availableDays.map((e) => e.toIso8601String()).toList(),
      'doctorSpecialty': doctorSpecialty,
      'doctorRating': doctorRating,
      'doctorRatingCount': doctorRatingCount,
      'clinicPrice': clinicPrice,
      'doctorImageUrl': doctorImageUrl,
      'doctorGender': doctorGender,
      'clinicLocation': clinicLocation,
      'clinicId': clinicId,
      'clinicName': clinicName,
    };
  }
}
