import '../../../medicines/data/models/medicine_model.dart';

class PharmacyMedicinesResponse {
  final List<MedicineModel> medicines;
  final List<MedicineModel> mostOrdered;

  PharmacyMedicinesResponse({
    required this.medicines,
    required this.mostOrdered,
  });

  factory PharmacyMedicinesResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return PharmacyMedicinesResponse(
      medicines: (data['medicines'] as List?)
              ?.map((e) => MedicineModel.fromJson(e))
              .toList() ??
          [],
      mostOrdered: (data['mostOrdered'] as List?)
              ?.map((e) => MedicineModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
