import 'package:chefaa/presentation/patient/pharmacy/pharmacies/data/models/Pharmacy_details.dart';
import 'package:dio/dio.dart';

import '../../../../../patient/pharmacy/pharmacies/data/models/pharmacy_medicines/Data.dart';

abstract class PharmacyPatientRepo {

  Future<Response> searchPharmacyAndMedicine({
  required String searchQuery,
  required int type,
  });

  Future<Data> getPharmacyMedicines({required String pharmacyId});

  Future<PharmacyDetails> pharmacyProfile({required String pharmacyId});

  Future<Response> addPharmacyReviews({
  required String pharmacyId,
  required int rating,
  required String comment,
  });
  }

