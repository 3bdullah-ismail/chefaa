import 'package:dio/dio.dart';

abstract class PharmacyRemoteDataSource {
  Future<Response<dynamic>> getPharmacyProfile(String pharmacyId);
  Future<Response<dynamic>> searchPharmacies(String query);
  Future<Response<dynamic>> getPharmacyMedicines(String pharmacyId);
  Future<Response<dynamic>> getMedicineDetails(String medicineId);
  Future<Response<dynamic>> addPharmacyReview(
    String pharmacyId,
    int rating,
    String comment,
  );
  Future<Response<dynamic>> checkoutOrder(Map<String, dynamic> checkoutData);
}
