import '../../../../doctor/layout/patients/data/models/patients/Medicines.dart';

class PrescriptionModel {
  String? id;
  String? diagnosis;
  List<Medicines> medicines;
  List<String> labTests;
  List<String> imaging;
  String? nextVisit;
  String? notes;

  PrescriptionModel({
    this.id,
    this.diagnosis,
    this.medicines = const [],
    this.labTests = const [],
    this.imaging = const [],
    this.nextVisit,
    this.notes,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      id: json['_id'],
      diagnosis: json['diagnosis'],
      medicines: (json['medicines'] as List? ?? [])
          .map((e) => Medicines.fromJson(e))
          .toList(),
      labTests:
      (json['labTests'] as List? ?? []).map((e) => e.toString()).toList(),
      imaging:
      (json['imaging'] as List? ?? []).map((e) => e.toString()).toList(),
      nextVisit: json['nextVisit'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'diagnosis': diagnosis,
      'medicines': medicines.map((e) => e.toJson()).toList(),
      'labTests': labTests,
      'imaging': imaging,
      'nextVisit': nextVisit,
      'notes': notes,
    };
  }
}