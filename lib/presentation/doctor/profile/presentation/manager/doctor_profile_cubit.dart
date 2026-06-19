import 'package:chefaa/presentation/doctor/profile/domain/entities/doctor_profile_entity.dart';
import 'package:chefaa/presentation/doctor/profile/domain/use_cases/get_doctor_data_use_case.dart';
import 'package:chefaa/presentation/doctor/profile/domain/use_cases/update_doctor_data_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'doctor_profile_state.dart';

@injectable
class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final GetDoctorDataUseCase getDoctorDataUseCase;
  final UpdateDoctorDataUseCase updateDoctorDataUseCase;

  DoctorProfileCubit({
    required this.getDoctorDataUseCase,
    required this.updateDoctorDataUseCase,
  }) : super(DoctorProfileInitial());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final specializationController = TextEditingController();
  final aboutController = TextEditingController();
  final ageController = TextEditingController();
  final yearsOfExperienceController = TextEditingController();
  final contactNumberController = TextEditingController();
  final clinicConsultationPriceController = TextEditingController();

  String? selectedGender;
  String? selectedPaymentOption;

  List<TextEditingController> degreeControllers = [];
  List<TextEditingController> prePaymentNumberControllers = [];
  DoctorProfileEntity? currentDoctor;
  bool profileCompleted = false;

  void initializeControllers(DoctorProfileEntity? d, {bool emitState = true}) {
    currentDoctor = d;
    profileCompleted = d?.isProfileCompleted() ?? false;
    nameController.text = d?.name ?? '';
    specializationController.text = d?.specialization ?? '';
    aboutController.text = d?.about ?? '';
    ageController.text = d?.age?.toString() ?? '';
    yearsOfExperienceController.text = d?.yearsOfExperience?.toString() ?? '';
    contactNumberController.text = d?.contactNumber ?? '';
    clinicConsultationPriceController.text =
        d?.clinicConsultationPrice?.toString() ?? '';

    final rawGender = d?.gender?.toLowerCase();
    selectedGender = (rawGender == 'female') ? 'Female' : 'Male';

    final rawPayment = d?.paymentOption?.toLowerCase();
    selectedPaymentOption = (rawPayment == 'postpayment')
        ? 'Postpayment'
        : 'Prepayment';

    final degrees = d?.degrees ?? [];
    degreeControllers = degrees.isEmpty
        ? [TextEditingController()]
        : degrees
              .map((e) => TextEditingController(text: e.toString()))
              .toList();

    final preNums = d?.prePaymentNumbers ?? [];
    prePaymentNumberControllers = preNums.isEmpty
        ? [TextEditingController()]
        : preNums
              .map((e) => TextEditingController(text: e.toString()))
              .toList();

    if (emitState) {
      emit(DoctorProfileControllersInitializedState());
    }
  }

  void changeGender(String? value) {
    selectedGender = value;
    emit(DoctorProfileUIUpdatedState());
  }

  void changePaymentOption(String? value) {
    selectedPaymentOption = value;
    emit(DoctorProfileUIUpdatedState());
  }

  void addDegreeField() {
    degreeControllers.add(TextEditingController());
    emit(DoctorProfileUIUpdatedState());
  }

  void removeDegreeField(int index) {
    if (degreeControllers.length > 1) {
      degreeControllers[index].dispose();
      degreeControllers.removeAt(index);
      emit(DoctorProfileUIUpdatedState());
    }
  }

  void addPrePaymentField() {
    prePaymentNumberControllers.add(TextEditingController());
    emit(DoctorProfileUIUpdatedState());
  }

  void removePrePaymentField(int index) {
    if (prePaymentNumberControllers.length > 1) {
      prePaymentNumberControllers[index].dispose();
      prePaymentNumberControllers.removeAt(index);
      emit(DoctorProfileUIUpdatedState());
    }
  }

  Future<void> getDoctorData() async {
    emit(GetDoctorDataLoadingState());
    final result = await getDoctorDataUseCase();
    result.fold(
      ifLeft: (failure) => emit(GetDoctorDataErrorState(failure.message)),
      ifRight: (data) {
        initializeControllers(data, emitState: false);
        emit(
          GetDoctorDataSuccessState(
            data,
            profileCompleted: data.isProfileCompleted(),
          ),
        );
      },
    );
  }

  Future<void> saveProfileChanges() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(UpdateDoctorDataLoadingState());

      final request = DoctorProfileEntity(
        name: nameController.text.trim(),
        specialization: specializationController.text.trim(),
        location: currentDoctor?.location ?? '',
        imageUrl: currentDoctor?.imageUrl ?? '',
        clinics: currentDoctor?.clinics ?? 0,
        rating: currentDoctor?.rating ?? 0,
        reviews: currentDoctor?.reviews ?? 0,
        about: aboutController.text.trim().isEmpty
            ? null
            : aboutController.text.trim(),
        age: int.tryParse(ageController.text.trim()),
        yearsOfExperience: int.tryParse(
          yearsOfExperienceController.text.trim(),
        ),
        contactNumber: contactNumberController.text.trim().isEmpty
            ? null
            : contactNumberController.text.trim(),
        clinicConsultationPrice: num.tryParse(
          clinicConsultationPriceController.text.trim(),
        ),
        gender: selectedGender?.toLowerCase(),
        degrees: degreeControllers
            .map((c) => c.text.trim())
            .where((s) => s.isNotEmpty)
            .toList(),
      );

      final result = await updateDoctorDataUseCase(request);
      result.fold(
        ifLeft: (failure) => emit(UpdateDoctorDataErrorState(failure.message)),
        ifRight: (data) {
          initializeControllers(data, emitState: false);
          emit(
            UpdateDoctorDataSuccessState(
              data,
              profileCompleted: data.isProfileCompleted(),
            ),
          );
        },
      );
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    specializationController.dispose();
    aboutController.dispose();
    ageController.dispose();
    yearsOfExperienceController.dispose();
    contactNumberController.dispose();
    clinicConsultationPriceController.dispose();
    for (final c in degreeControllers) {
      c.dispose();
    }
    for (final c in prePaymentNumberControllers) {
      c.dispose();
    }
    return super.close();
  }
}
