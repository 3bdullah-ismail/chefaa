import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../profile/data/repositories/pharmacy_profile_repo.dart';
import '../../data/repositories/pharmacy_settings_repo.dart';
import '../../data/models/pharmacy_status_response.dart';

part 'pharmacy_settings_state.dart';

@injectable
class PharmacySettingsCubit extends Cubit<PharmacySettingsState> {
  final PharmacyProfileRepo pharmacyProfileRepo;
  final PharmacySettingsRepo pharmacySettingsRepo;

  PharmacySettingsCubit(this.pharmacyProfileRepo, this.pharmacySettingsRepo)
      : super(PharmacySettingsInitial());

  Future<void> loadSettingsStatus() async {
    emit(PharmacySettingsLoadLoading());
    try {
      final profile = await pharmacyProfileRepo.getPharmacyProfile();
      final openNow = profile.data?.openNow ?? false;
      final deliveryAvailable = profile.data?.deliveryAvailable ?? false;
      emit(PharmacySettingsLoadSuccess(
        openNow: openNow,
        deliveryAvailable: deliveryAvailable,
      ));
    } catch (e) {
      emit(PharmacySettingsLoadError(e.toString()));
    }
  }

  Future<void> updateStatus(bool openNow) async {
    final currentState = state;
    bool currentDeliveryAvailable = false;
    if (currentState is PharmacySettingsLoadSuccess) {
      currentDeliveryAvailable = currentState.deliveryAvailable;
    }

    emit(PharmacySettingsUpdateLoading());
    try {
      final response = await pharmacySettingsRepo.updateStatus({
        "openNow": openNow,
      });
      emit(PharmacySettingsUpdateSuccess(response));
      emit(PharmacySettingsLoadSuccess(
        openNow: response.data?.openNow ?? openNow,
        deliveryAvailable: response.data?.deliveryAvailable ?? currentDeliveryAvailable,
      ));
    } catch (e) {
      emit(PharmacySettingsUpdateError(e.toString()));
      emit(PharmacySettingsLoadSuccess(
        openNow: !openNow,
        deliveryAvailable: currentDeliveryAvailable,
      ));
    }
  }
}
