
import 'package:chefaa/presentation/Facility/profile/data/models/get_profile_response.dart';

abstract class ProfileRepository {
  Future<GetProfileResponse> getProfile();
  Future<GetProfileResponse> updateProfile(Map<String, dynamic> body);
}

