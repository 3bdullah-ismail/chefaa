part of 'pharmacy_settings_cubit.dart';

sealed class PharmacySettingsState {}

final class PharmacySettingsInitial extends PharmacySettingsState {}

// Load settings status
final class PharmacySettingsLoadLoading extends PharmacySettingsState {}

final class PharmacySettingsLoadSuccess extends PharmacySettingsState {
  final bool openNow;
  final bool deliveryAvailable;

  PharmacySettingsLoadSuccess({
    required this.openNow,
    required this.deliveryAvailable,
  });
}

final class PharmacySettingsLoadError extends PharmacySettingsState {
  final String errorMessage;

  PharmacySettingsLoadError(this.errorMessage);
}

// Update settings status
final class PharmacySettingsUpdateLoading extends PharmacySettingsState {}

final class PharmacySettingsUpdateSuccess extends PharmacySettingsState {
  final PharmacyStatusResponse response;

  PharmacySettingsUpdateSuccess(this.response);
}

final class PharmacySettingsUpdateError extends PharmacySettingsState {
  final String errorMessage;

  PharmacySettingsUpdateError(this.errorMessage);
}
