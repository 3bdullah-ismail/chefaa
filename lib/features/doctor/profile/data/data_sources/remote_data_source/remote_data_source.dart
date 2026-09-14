import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/features/doctor/profile/domain/entities/doctor_profile_entity.dart';

abstract class DoctorProfileRemoteDataSource {
  Future<Response> getDoctorData();

  Future<Response> upDateDoctorData(DoctorProfileEntity request);
}
