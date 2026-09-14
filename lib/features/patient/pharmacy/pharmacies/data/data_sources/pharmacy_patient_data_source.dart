import 'package:chefaa/core/imports/imports.dart';

abstract class PharmacyPatientDataSource {
  Future<Response> searchPharmacyAndMedicine({
    required String searchQuery,
    required int type,
  });

  Future<Response> getPharmacyMedicines({required String pharmacyId});

  Future<Response> pharmacyProfile({required String pharmacyId});

  Future<Response> addPharmacyReviews({
    required String pharmacyId,
    required int rating,
    required String comment,
  });
}
