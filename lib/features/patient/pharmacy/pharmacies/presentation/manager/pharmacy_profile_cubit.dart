import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/features/patient/pharmacy/pharmacies/data/models/pharmacy_profile_model.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/domain/repositories/pharmacy_profile_repo.dart';

part 'pharmacy_profile_state.dart';

@injectable
class PharmacyProfileCubit extends Cubit<PharmacyProfileState> {
  final PharmacyProfileRepo pharmacyProfileRepo;

  PharmacyProfileCubit(this.pharmacyProfileRepo) : super(PharmacyProfileInitial());

  Future<void> getPharmacyProfile(String pharmacyId) async {
      if (!isClosed) emit(PharmacyProfileLoading());

    final result = await pharmacyProfileRepo.getPharmacyProfile(pharmacyId);

    result.fold(
      ifLeft: (failure) => isClosed ? null : emit(PharmacyProfileFailure(failure.message)),
      ifRight: (pharmacyProfile) => isClosed ? null : emit(PharmacyProfileSuccess(pharmacyProfile)),
    );
  }
}
