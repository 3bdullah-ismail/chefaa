import 'package:chefaa/presentation/patient/auth/data/repositories/patient_repo.dart';
import 'package:chefaa/presentation/patient/auth/presentation/manager/patient_state.dart';
import 'package:chefaa/core/utils/username_generator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/storage_service.dart';
import '../../../home/presentation/manager/users_cubit.dart';

@injectable
class PatientCubit extends Cubit<PatientState> {
  final PatientRepo patientRepo;
  late final String role;
  final UsersCubit usersCubit;

  PatientCubit({required this.patientRepo, required this.usersCubit})
    : super(PatientInitial());

  PatientCubit.initial({required this.patientRepo, required this.usersCubit})
    : super(PatientInitial());

  void setRole(String role) {
    this.role = role;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  static PatientCubit get(BuildContext context) => BlocProvider.of(context);

  bool _isSigningUp = false;

  Future<void> patientSignUp() async {
    if (_isSigningUp) return;
    _isSigningUp = true;
    emit(SignUpLoadingState());
    try {
      final String fullName = "${nameController.text} ${lastNameController.text}".trim();
      var response = await patientRepo.patientSignUp(
        name: fullName,
        userName: UsernameGenerator.generate(fullName),
        phone: phoneController.text,
        email: emailController.text,
        password: passwordController.text,
        role: role,
      );
      if (response.user != null) {
        await StorageService.saveUser(response.user!);
      }
      if (response.accessToken != null) {
        await StorageService.saveToken(response.accessToken!);
      }
      await usersCubit.setUser(response);
      emit(
        SignUpSuccessState(message: response.message, patient: response.user),
      );
    } catch (e) {
      emit(SignUpErrorState(e.toString()));
    } finally {
      _isSigningUp = false;
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
