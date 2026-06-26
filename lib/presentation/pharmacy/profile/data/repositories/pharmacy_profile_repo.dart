import 'package:chefaa/presentation/pharmacy/profile/data/models/pharmacy_profile_response.dart';

abstract class PharmacyProfileRepo {
  Future<PharmacyProfileResponse> getPharmacyProfile();
  Future<PharmacyProfileResponse> updatePharmacyProfile(
    Map<String, dynamic> body,
  );
}
