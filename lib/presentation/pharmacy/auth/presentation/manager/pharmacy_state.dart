import 'package:file_picker/file_picker.dart';

import '../../data/models/Pharmacy.dart';

sealed class PharmacyState {}

final class PharmacyInitial extends PharmacyState {}

final class PharmacyLoadingState extends PharmacyState {}

final class PharmacySuccessState extends PharmacyState {
  final Pharmacy pharmacy;
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
