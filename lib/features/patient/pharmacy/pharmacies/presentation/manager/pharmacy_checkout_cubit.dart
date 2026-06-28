import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/features/patient/pharmacy/pharmacies/data/models/checkout_response.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/domain/repositories/pharmacy_profile_repo.dart';

part 'pharmacy_checkout_state.dart';

@injectable
class PharmacyCheckoutCubit extends Cubit<PharmacyCheckoutState> {
  final PharmacyProfileRepo pharmacyProfileRepo;

  PharmacyCheckoutCubit(this.pharmacyProfileRepo)
      : super(PharmacyCheckoutInitial());

  Future<void> checkoutOrder(Map<String, dynamic> checkoutData) async {
      if (!isClosed) emit(PharmacyCheckoutLoading());

    final result = await pharmacyProfileRepo.checkoutOrder(checkoutData);

    result.fold(
      ifLeft: (failure) => isClosed ? null : emit(PharmacyCheckoutFailure(failure.message)),
      ifRight: (response) => isClosed ? null : emit(PharmacyCheckoutSuccess(response)),
    );
  }
}
