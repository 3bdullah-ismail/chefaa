import 'package:chefaa/presentation/patient/search/domain/entities/doctor_model.dart';

abstract class SearchRepo {
  Future<List<DoctorModel>?> filterSearch({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  });
}
