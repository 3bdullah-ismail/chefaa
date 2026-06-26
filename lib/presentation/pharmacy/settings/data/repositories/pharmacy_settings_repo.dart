import 'package:chefaa/presentation/pharmacy/settings/data/models/pharmacy_status_response.dart';

abstract class PharmacySettingsRepo {
  Future<PharmacyStatusResponse> updateStatus(Map<String, dynamic> body);
}
