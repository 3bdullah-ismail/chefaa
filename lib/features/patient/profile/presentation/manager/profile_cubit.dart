import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/profile_repo.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  UserProfileEntity? _profileSnapshot;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController chronicController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  double? latitude;
  double? longitude;

  String gender = "Male";

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  void _cacheProfile(UserProfileEntity profile) {
    _profileSnapshot = profile;

    if (profile.userName != null && profile.userName!.trim().isNotEmpty) {
      nameController.text = profile.userName!.trim();
    }

    if (profile.age != null) {
      ageController.text = profile.age.toString();
    }

    if (profile.userHeight != null) {
      heightController.text = profile.userHeight.toString();
    }

    if (profile.userWeight != null) {
      weightController.text = profile.userWeight.toString();
    }

    if (profile.userBloodType != null &&
        profile.userBloodType!.trim().isNotEmpty) {
      bloodTypeController.text = profile.userBloodType!.trim();
    }

    if (profile.allergiesList != null) {
      allergiesController.text = profile.allergiesList!.join(', ');
    }

    if (profile.chronicConditionsList != null) {
      chronicController.text = profile.chronicConditionsList!.join(', ');
    }

    if (profile.userAddress != null && profile.userAddress!.trim().isNotEmpty) {
      locationController.text = profile.userAddress!.trim();
    }

    if (profile.userGender != null && profile.userGender!.trim().isNotEmpty) {
      gender = profile.userGender!.trim();
    }
  }

  AddressEntity _buildAddressEntity() {
    final addressText = locationController.text.trim().isNotEmpty
        ? locationController.text.trim()
        : _profileSnapshot?.userAddress?.trim() ?? '';

    return AddressEntity(
      addressText: addressText,
      longitude: longitude!,
      latitude: latitude!,
    );
  }

  void setLocation({
    required String addressText,
    required double lat,
    required double lng,
  }) {
    locationController.text = addressText;
    latitude = lat;
    longitude = lng;
    emit(LocationPickedState(addressText: addressText, lat: lat, lng: lng));
  }

  bool get isLocationMissing =>
      (locationController.text.trim().isEmpty &&
          (_profileSnapshot?.userAddress?.trim().isEmpty ?? true)) ||
          latitude == null ||
          longitude == null;

  Future<void> getProfileData() async {
    emit(GetProfileDataLoadingState());

    var result = await profileRepo.getProfileData();

    result.fold(
      ifLeft: (failure) => emit(GetProfileDataFailureState(failure.message)),
      ifRight: (profileData) {
        _cacheProfile(profileData);
        emit(GetProfileDataSuccessState(profileData));
      },
    );
  }

  Future<void> updateProfileData() async {
    if (isLocationMissing) {
      emit(UpdateProfileDataFailureState("Please choose your location"));
      return;
    }

    emit(UpdateProfileDataLoadingState());

    final cachedProfile = _profileSnapshot;
    final name = nameController.text.trim().isNotEmpty
        ? nameController.text.trim()
        : cachedProfile?.userName;
    final genderValue = gender.trim().isNotEmpty
        ? gender.toLowerCase().trim()
        : cachedProfile?.userGender?.toLowerCase().trim();
    final age = num.tryParse(ageController.text.trim()) ?? cachedProfile?.age;
    final height =
        num.tryParse(heightController.text.trim()) ?? cachedProfile?.userHeight;
    final weight =
        num.tryParse(weightController.text.trim()) ?? cachedProfile?.userWeight;

    final result = await profileRepo.updateProfileData(
      name,
      genderValue,
      age,
      height,
      weight,
      _buildAddressEntity(),
    );

    result.fold(
      ifLeft: (failure) => emit(UpdateProfileDataFailureState(failure.message)),
      ifRight: (profileData) {
        _cacheProfile(profileData);
        emit(UpdateProfileDataSuccessState(profileData));
      },
    );
  }

  Future<void> updateMedicalInformation() async {
    emit(UpdateMedicalInformationLoadingState());

    final bloodType = bloodTypeController.text.trim();

    final allergiesList = allergiesController.text.trim().isEmpty
        ? <String>[]
        : allergiesController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final chronicConditionsList = chronicController.text.trim().isEmpty
        ? <String>[]
        : chronicController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final result = await profileRepo.updateMedicalData(
      bloodType: bloodType,
      allergiesList: allergiesList,
      chronicConditionsList: chronicConditionsList,
    );

    result.fold(
      ifLeft: (failure) =>
          emit(UpdateMedicalInformationFailureState(failure.message)),
      ifRight: (profileData) {
        _cacheProfile(profileData);
        emit(UpdateMedicalInformationSuccessState(profileData));
      },
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    weightController.dispose();
    heightController.dispose();
    ageController.dispose();
    bloodTypeController.dispose();
    allergiesController.dispose();
    chronicController.dispose();
    locationController.dispose();
    return super.close();
  }
}
