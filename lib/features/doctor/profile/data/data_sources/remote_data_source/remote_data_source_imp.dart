import 'package:chefaa/core/services/network_service.dart';
import 'package:chefaa/features/doctor/profile/data/data_sources/remote_data_source/remote_data_source.dart';
import 'package:chefaa/features/doctor/profile/domain/entities/doctor_profile_entity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DoctorProfileRemoteDataSource)
class DoctorProfileRemoteDataSourceImp extends DoctorProfileRemoteDataSource {
  NetworkService networkService;

  DoctorProfileRemoteDataSourceImp(this.networkService);

  @override
  Future<Response> getDoctorData() {
    return networkService.dio.get("/doctor/profile");
  }

  @override
  Future<Response<dynamic>> upDateDoctorData(DoctorProfileEntity request) {
    return networkService.dio.put("/doctor/profile", data: _buildBody(request));
  }

  Map<String, dynamic> _buildBody(DoctorProfileEntity request) {
    return {
      if (request.name != null) 'name': request.name,
      if (request.specialization != null)
        'specialization': request.specialization,
      if (request.about != null) 'about': request.about,
      if (request.age != null) 'age': request.age,
      if (request.yearsOfExperience != null)
        'yearsOfExperience': request.yearsOfExperience,
      if (request.contactNumber != null) 'contactNumber': request.contactNumber,
      if (request.clinicConsultationPrice != null)
        'clinicConsultationPrice': request.clinicConsultationPrice,
      if (request.gender != null) 'gender': request.gender,
      if (request.paymentOption != null) 'paymentOption': request.paymentOption,
      if (request.degrees != null) 'degrees': request.degrees,
      'prePaymentNumbers': request.prePaymentNumbers ?? [],
    };
  }
}
