import 'package:dart_either/dart_either.dart';
import 'package:chefaa/core/error_handling/failure.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/data/models/pharmacy_profile_model.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/data/models/search_pharmacies_response.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/data/models/pharmacy_medicines_response.dart';
import 'package:chefaa/features/patient/pharmacy/medicines/data/models/medicine_details_model.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/data/models/checkout_response.dart';

abstract class PharmacyProfileRepo {
  Future<Either<Failure, PharmacyProfileModel>> getPharmacyProfile(
    String pharmacyId,
  );
  Future<Either<Failure, SearchPharmaciesResponse>> searchPharmacies(
    String query,
  );
  Future<Either<Failure, PharmacyMedicinesResponse>> getPharmacyMedicines(
    String pharmacyId,
  );
  Future<Either<Failure, MedicineDetailsModel>> getMedicineDetails(
    String medicineId,
  );
  Future<Either<Failure, void>> addPharmacyReview(
    String pharmacyId,
    int rating,
    String comment,
  );
  Future<Either<Failure, CheckoutResponse>> checkoutOrder(
    Map<String, dynamic> checkoutData,
  );
}
