import 'package:chefaa/presentation/doctor/profile/domain/entities/doctor_profile_entity.dart';

abstract class DoctorProfileLocalDataSource {
  Future<void> cacheDoctorProfile(DoctorProfileEntity doctor);

  Future<DoctorProfileEntity?> getCachedDoctorProfile();

  Future<void> clearCachedDoctorProfile();
}
