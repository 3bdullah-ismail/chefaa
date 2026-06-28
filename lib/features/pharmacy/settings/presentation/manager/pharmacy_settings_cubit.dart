import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:chefaa/features/pharmacy/profile/domain/repositories/pharmacy_profile_repo.dart';
import 'package:chefaa/features/pharmacy/settings/domain/repositories/pharmacy_settings_repo.dart';
import 'package:chefaa/features/pharmacy/settings/data/models/pharmacy_status_response.dart';

part 'pharmacy_settings_state.dart';

@injectable
class PharmacySettingsCubit extends Cubit<PharmacySettingsState> {
  final PharmacyProfileRepo pharmacyProfileRepo;
  final PharmacySettingsRepo pharmacySettingsRepo;

  PharmacySettingsCubit(this.pharmacyProfileRepo, this.pharmacySettingsRepo)
      : super(PharmacySettingsInitial());

  Future<void> loadSettingsStatus() async {
      if (!isClosed) emit(PharmacySettingsLoadLoading());
    try {
      final profile = await pharmacyProfileRepo.getPharmacyProfile();
      final openNow = profile.data?.openNow ?? false;
      final deliveryAvailable = profile.data?.deliveryAvailable ?? false;
      if (!isClosed) {
        emit(PharmacySettingsLoadSuccess(
        openNow: openNow,
        deliveryAvailable: deliveryAvailable,
      ));
      }
    } catch (e) {
      if (!isClosed) emit(PharmacySettingsLoadError(e.toString()));
    }
  }

  Future<void> updateStatus(bool openNow) async {
    final currentState = state;
    bool currentDeliveryAvailable = false;
    if (currentState is PharmacySettingsLoadSuccess) {
      currentDeliveryAvailable = currentState.deliveryAvailable;
    }
      if (!isClosed) emit(PharmacySettingsUpdateLoading());
    try {
      final response = await pharmacySettingsRepo.updateStatus({
        "openNow": openNow,
      });
      if (!isClosed) emit(PharmacySettingsUpdateSuccess(response));
      if (!isClosed) {
        emit(PharmacySettingsLoadSuccess(
        openNow: response.data?.openNow ?? openNow,
        deliveryAvailable: response.data?.deliveryAvailable ?? currentDeliveryAvailable,
      ));
      }
    } catch (e) {
      if (!isClosed) emit(PharmacySettingsUpdateError(e.toString()));
      if (!isClosed) {
        emit(PharmacySettingsLoadSuccess(
        openNow: !openNow,
        deliveryAvailable: currentDeliveryAvailable,
      ));
      }
    }
  }
}
