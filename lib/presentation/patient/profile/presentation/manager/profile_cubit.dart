import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/profile_repo.dart';
import '../../domain/entities/user_profile_entity.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController chronicController = TextEditingController();

  String gender = "Male";

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getProfileData() async {
    emit(GetProfileDataLoadingState());

    var result = await profileRepo.getProfileData();

    result.fold(
      ifLeft: (failure) => emit(GetProfileDataFailureState(failure.message)),
      ifRight: (profileData) => emit(GetProfileDataSuccessState(profileData)),
    );
  }

  Future<void> updateProfileData() async {
    emit(UpdateProfileDataLoadingState());

    final result = await profileRepo.updateProfileData(
      nameController.text.trim().isEmpty ? null : nameController.text.trim(),
      gender.trim().isEmpty ? null : gender.toLowerCase().trim(),
      num.tryParse(ageController.text.trim()),
      num.tryParse(heightController.text.trim()),
      num.tryParse(weightController.text.trim()),
    );

    result.fold(
      ifLeft: (failure) => emit(UpdateProfileDataFailureState(failure.message)),
      ifRight: (profileData) =>
          emit(UpdateProfileDataSuccessState(profileData)),
    );
  }
}
