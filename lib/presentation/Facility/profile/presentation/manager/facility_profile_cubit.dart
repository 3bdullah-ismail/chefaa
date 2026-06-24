import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/get_profile_response.dart';
import '../../data/repositories/profile_repository.dart';

part 'facility_profile_state.dart';

@injectable
class FacilityProfileCubit extends Cubit<FacilityProfileState> {
  final ProfileRepository _profileRepository;

  ProfileData? profileData;

  FacilityProfileCubit(this._profileRepository) : super(FacilityProfileInitial());

  static FacilityProfileCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getProfile() async {
    emit(GetProfileLoading());
    try {
      final response = await _profileRepository.getProfile();
      profileData = response.profileData;
      emit(GetProfileSuccess(response));
    } catch (e) {
      emit(GetProfileFailure(e.toString()));
    }
  }

  Future<void> updateProfile(Map<String, dynamic> body) async {
    emit(UpdateProfileLoading());
    try {
      final response = await _profileRepository.updateProfile(body);
      profileData = response.profileData;
      emit(UpdateProfileSuccess(response));
    } catch (e) {
      emit(UpdateProfileFailure(e.toString()));
    }
  }
}
