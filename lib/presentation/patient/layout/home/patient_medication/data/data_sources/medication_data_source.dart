import 'package:dio/dio.dart';

abstract class MedicationDataSource {
  Future<Response> getMedicationList();
  Future<Response> addMedication({
    required String name,
    required String dosage,
    required String form,
    required int timesPerDay,
    required List<String> schedule,
    required String startDate,
    required String endDate,
    required bool isActive,
});
  Future<Response> updateMedication({
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
  Future<Response> deleteMedication(String medicationId);
  Future<Response> confirmMedication(String medicationId);
}