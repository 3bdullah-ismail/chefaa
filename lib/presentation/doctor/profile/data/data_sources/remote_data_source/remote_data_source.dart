import 'package:dio/dio.dart';

import '../../models/update_doctor_profile_request.dart';

abstract class DoctorProfileRemoteDataSource {
  Future<Response> getDoctorData();

  Future<Response> upDateDoctorData(UpdateDoctorProfileRequest request);
}
