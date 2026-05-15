import 'package:chefaa/presentation/doctor/auth/data/repositories/repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/storage_service.dart';
import '../../../../patient/layout/home/presentation/manager/users_cubit.dart';

part 'doctor_auth_state.dart';

@injectable
class DoctorAuthCubit extends Cubit<DoctorAuthState> {
  DoctorAuthRepo doctorAuthRepo;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController specialization = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isSigningUp = false;

  final UsersCubit usersCubit;
  static DoctorAuthCubit get(context) => BlocProvider.of(context);

  DoctorAuthCubit({required this.doctorAuthRepo, required this.usersCubit})
      : super(DoctorAuthInitial());
  DoctorAuthCubit.initial({required this.doctorAuthRepo, required this.usersCubit})
      : super(DoctorAuthInitial());

  Future<void> signUp({required PlatformFile? membershipFile}) async {
    if (_isSigningUp) return;
    _isSigningUp = true;
    if (membershipFile == null) {
      emit(SingUpFailure("Please upload your membership file"));
      _isSigningUp = false;
      return;
    }
    emit(SingUpLoading());
    try {
      final response = await doctorAuthRepo.signUp(
        name: name.text,
        email: email.text,
        username: username.text,
        password: password.text,
        phoneNumber: phoneNumber.text,
        specialization: specialization.text,
        membership: membershipFile,
      );
      if (response.user != null) {
        await StorageService.saveUser(response.user!);
      }
      if (response.accessToken != null) {
        await StorageService.saveToken(response.accessToken!);
      }
      await usersCubit.setUser(response);
      emit(SingUpSuccess(userName: response.user!.name ?? ""));
    } catch (e) {
      emit(SingUpFailure(e.toString()));
    } finally {
      _isSigningUp = false;
    }
  }

  @override
  Future<void> close() {
    name.dispose();
    email.dispose();
    username.dispose();
    password.dispose();
    phoneNumber.dispose();
    specialization.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
