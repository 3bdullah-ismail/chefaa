import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:chefaa/features/facility/profile/data/models/get_profile_response.dart';
import 'package:chefaa/features/facility/profile/domain/repositories/profile_repository.dart';

part 'facility_profile_state.dart';

@injectable
class FacilityProfileCubit extends Cubit<FacilityProfileState> {
  final ProfileRepository _profileRepository;

  ProfileData? profileData;

  FacilityProfileCubit(this._profileRepository)
    : super(FacilityProfileInitial());

  static FacilityProfileCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getProfile() async {
      if (!isClosed) emit(GetProfileLoading());
    try {
      final response = await _profileRepository.getProfile();
      profileData = response.profileData;
      if (!isClosed) emit(GetProfileSuccess(response));
    } catch (e) {
      if (!isClosed) emit(GetProfileFailure(e.toString()));
    }
  }

  Future<void> updateProfile(Map<String, dynamic> body) async {
      if (!isClosed) emit(UpdateProfileLoading());
    try {
      final response = await _profileRepository.updateProfile(body);
      profileData = response.profileData;
      if (!isClosed) emit(UpdateProfileSuccess(response));
    } catch (e) {
      if (!isClosed) emit(UpdateProfileFailure(e.toString()));
    }
  }
}
