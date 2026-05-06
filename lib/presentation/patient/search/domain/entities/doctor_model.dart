import 'package:hive/hive.dart';

part "doctor_model.g.dart";

@HiveType(typeId: 0)
class DoctorModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String specialty;
  @HiveField(2)
  final String rating;
  @HiveField(3)
  final String ratingCount;
  @HiveField(4)
  final String price;
  @HiveField(5)
  final String? imageUrl;
  @HiveField(6)
  final String? gender;
  @HiveField(7)
  final String? location;
  @HiveField(8)
  final List<DateTime> availableDays;
  @HiveField(9)
  final String clinkId;

  const DoctorModel({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.ratingCount,
    required this.price,
    this.imageUrl,
    this.gender,
    this.location,
    required this.availableDays,
    required this.clinkId,
  });
}
