part of 'pharmacy_cubit.dart';

sealed class PharmacyState {}

final class PharmacyInitial extends PharmacyState {}

final class PharmacyLoadingState extends PharmacyState {}

final class PharmacySuccessState extends PharmacyState {
  final User pharmacy;
  final String message;

  PharmacySuccessState(this.pharmacy, this.message);
}

final class PharmacyErrorState extends PharmacyState {
  final String message;

  PharmacyErrorState(this.message);
}

final class UploadMembershipState extends PharmacyState {
  final PlatformFile? file;

  UploadMembershipState({this.file});
}
