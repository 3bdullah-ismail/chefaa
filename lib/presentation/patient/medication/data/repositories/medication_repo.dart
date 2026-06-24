import 'package:chefaa/presentation/patient/medication/data/models/medication_list.dart';

import '../models/confirm_medication.dart';
import '../models/medication_response.dart';

abstract class MedicationRepo {
  Future<MedicationResponse> addMedication({
    required String name,
    required String dosage,
    required String form,
    required int timesPerDay,
    required List<String> schedule,
    required String startDate,
    required String endDate,
    required bool isActive,
  });

  Future<ConfirmMedication> confirmMedication(String medicationId);

  Future<MedicationList> getMedicationList();

  Future<MedicationResponse> updateMedication({
    required String medicationId,
    required String name,
    required String dosage,
    required String form,
    required int timesPerDay,
    required List<String> schedule,
    required String startDate,
    required String endDate,
    required bool isActive,
  });

  Future<MedicationResponse> deleteMedication(String medicationId);
}
