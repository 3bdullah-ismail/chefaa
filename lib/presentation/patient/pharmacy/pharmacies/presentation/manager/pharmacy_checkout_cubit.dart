import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/checkout_response.dart';
import '../../domain/repositories/pharmacy_profile_repo.dart';

part 'pharmacy_checkout_state.dart';

@injectable
class PharmacyCheckoutCubit extends Cubit<PharmacyCheckoutState> {
  final PharmacyProfileRepo pharmacyProfileRepo;

  PharmacyCheckoutCubit(this.pharmacyProfileRepo)
      : super(PharmacyCheckoutInitial());

  Future<void> checkoutOrder(Map<String, dynamic> checkoutData) async {
    emit(PharmacyCheckoutLoading());

    final result = await pharmacyProfileRepo.checkoutOrder(checkoutData);

    result.fold(
      ifLeft: (failure) => emit(PharmacyCheckoutFailure(failure.message)),
      ifRight: (response) => emit(PharmacyCheckoutSuccess(response)),
    );
  }
}
