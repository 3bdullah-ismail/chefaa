import 'package:dio/dio.dart';

import 'package:chefaa/features/doctor/profile/domain/entities/doctor_profile_entity.dart';

abstract class DoctorProfileRemoteDataSource {
  Future<Response> getDoctorData();

  Future<Response> upDateDoctorData(DoctorProfileEntity request);
}
