import 'package:chefaa/core/services/hive_service.dart';
import 'package:chefaa/presentation/doctor/profile/data/data_sources/local_data_source/doctor_profile_local_data_source.dart';
import 'package:chefaa/presentation/doctor/profile/data/models/doctor_data.dart';
import 'package:chefaa/presentation/doctor/profile/domain/entities/doctor_profile_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DoctorProfileLocalDataSource)
class DoctorProfileLocalDataSourceImp implements DoctorProfileLocalDataSource {
  static const String _doctorProfileKey = 'doctor_profile_cache_v1';

  @override
  Future<void> cacheDoctorProfile(DoctorProfileEntity doctor) async {
    final payload = <String, dynamic>{
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
      'data': _toCacheMap(doctor),
    };
    await HiveService.put(HiveBoxes.doctorsBox, _doctorProfileKey, payload);
  }

  @override
  Future<DoctorProfileEntity?> getCachedDoctorProfile() async {
    final dynamic raw = await HiveService.get<dynamic>(
      HiveBoxes.doctorsBox,
      _doctorProfileKey,
    );

    if (raw is! Map) return null;

    final dynamic data = raw['data'];
    if (data is! Map) return null;

    try {
      final map = Map<String, dynamic>.from(data);
      return DoctorData.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clearCachedDoctorProfile() async {
    await HiveService.delete(HiveBoxes.doctorsBox, _doctorProfileKey);
  }

  Map<String, dynamic> _toCacheMap(DoctorProfileEntity doctor) {
    if (doctor is DoctorData) {
      return doctor.toJson();
    }

    return {
      'name': doctor.name,
      'specialization': doctor.specialization,
      'image': doctor.imageUrl,
      'about': doctor.about,
      'degrees': doctor.degrees,
      'rating': doctor.rating,
      'paymentOption': doctor.paymentOption,
      'prePaymentNumbers': doctor.prePaymentNumbers,
      'clinicConsultationPrice': doctor.clinicConsultationPrice,
      'clinics': const <dynamic>[],
      'reviews': const <dynamic>[],
      'contactNumber': doctor.contactNumber,
      'membershipPdf': null,
      'age': doctor.age,
      'yearsOfExperience': doctor.yearsOfExperience,
      'gender': doctor.gender,
      'email': null,
    };
  }
}

