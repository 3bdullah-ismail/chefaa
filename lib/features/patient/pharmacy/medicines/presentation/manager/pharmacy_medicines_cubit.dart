import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/features/patient/pharmacy/pharmacies/data/models/pharmacy_medicines_response.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/domain/repositories/pharmacy_profile_repo.dart';

part 'pharmacy_medicines_state.dart';

@injectable
class PharmacyMedicinesCubit extends Cubit<PharmacyMedicinesState> {
  final PharmacyProfileRepo pharmacyProfileRepo;

  PharmacyMedicinesCubit(this.pharmacyProfileRepo)
      : super(PharmacyMedicinesInitial());

  Future<void> getPharmacyMedicines(String pharmacyId) async {
      if (!isClosed) emit(PharmacyMedicinesLoading());

    final result = await pharmacyProfileRepo.getPharmacyMedicines(pharmacyId);

    result.fold(
      ifLeft: (failure) => isClosed ? null : emit(PharmacyMedicinesFailure(failure.message)),
      ifRight: (response) => isClosed ? null : emit(PharmacyMedicinesSuccess(response)),
    );
  }
}
