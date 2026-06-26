import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/pharmacy_profile_model.dart';
import '../../domain/repositories/pharmacy_profile_repo.dart';

part 'pharmacy_profile_state.dart';

@injectable
class PharmacyProfileCubit extends Cubit<PharmacyProfileState> {
  final PharmacyProfileRepo pharmacyProfileRepo;

  PharmacyProfileCubit(this.pharmacyProfileRepo) : super(PharmacyProfileInitial());

  Future<void> getPharmacyProfile(String pharmacyId) async {
    emit(PharmacyProfileLoading());

    final result = await pharmacyProfileRepo.getPharmacyProfile(pharmacyId);

    result.fold(
      ifLeft: (failure) => emit(PharmacyProfileFailure(failure.message)),
      ifRight: (pharmacyProfile) => emit(PharmacyProfileSuccess(pharmacyProfile)),
    );
  }
}
