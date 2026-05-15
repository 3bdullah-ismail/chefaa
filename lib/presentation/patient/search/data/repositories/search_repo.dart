import 'package:chefaa/presentation/patient/search/domain/entities/clinic_model.dart';

abstract class SearchRepo {
  Future<List<ClinicModel>?> filterSearch({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  });
}
