import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/features/patient/pharmacy/pharmacies/data/models/search_pharmacies_response.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/domain/repositories/pharmacy_profile_repo.dart';

part 'pharmacy_search_state.dart';

@injectable
class PharmacySearchCubit extends Cubit<PharmacySearchState> {
  final PharmacyProfileRepo pharmacyProfileRepo;

  PharmacySearchCubit(this.pharmacyProfileRepo) : super(PharmacySearchInitial());

  Future<void> searchPharmacies(String query) async {
      if (!isClosed) emit(PharmacySearchLoading());

    final result = await pharmacyProfileRepo.searchPharmacies(query);

    result.fold(
      ifLeft: (failure) => isClosed ? null : emit(PharmacySearchFailure(failure.message)),
      ifRight: (response) => isClosed ? null : emit(PharmacySearchSuccess(response)),
    );
  }
}

