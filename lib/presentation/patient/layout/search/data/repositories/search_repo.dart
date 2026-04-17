import '../../domain/entities/doctor_clinic.dart';
import '../models/Clinics.dart';

abstract class SearchRepo {
  Future<List<DoctorClinic>?> filterSearch({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  });
}
