import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:chefaa/features/pharmacy/profile/domain/repositories/pharmacy_profile_repo.dart';
import 'package:chefaa/features/pharmacy/profile/data/models/pharmacy_profile_response.dart';

part 'pharmacy_profile_state.dart';

@injectable
class PharmacyProfileCubit extends Cubit<PharmacyProfileState> {
  final PharmacyProfileRepo pharmacyProfileRepo;

  PharmacyProfileCubit(this.pharmacyProfileRepo)
    : super(PharmacyProfileInitial());

  Future<void> getPharmacyProfile() async {
      if (!isClosed) emit(PharmacyProfileLoading());
    try {
      final response = await pharmacyProfileRepo.getPharmacyProfile();
      if (!isClosed) emit(PharmacyProfileSuccess(response));
    } catch (e) {
      if (!isClosed) emit(PharmacyProfileError(e.toString()));
    }
  }

  Future<void> updatePharmacyProfile(Map<String, dynamic> body) async {
      if (!isClosed) emit(PharmacyProfileUpdateLoading());
    try {
      final response = await pharmacyProfileRepo.updatePharmacyProfile(body);
      if (!isClosed) emit(PharmacyProfileUpdateSuccess(response));
    } catch (e) {
      if (!isClosed) emit(PharmacyProfileUpdateError(e.toString()));
    }
  }
}
