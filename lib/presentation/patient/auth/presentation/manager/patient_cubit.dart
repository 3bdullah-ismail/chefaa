import 'package:chefaa/presentation/patient/auth/data/repositories/patient_repo.dart';
import 'package:chefaa/presentation/patient/auth/presentation/manager/patient_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/storage_service.dart';

@injectable
class PatientCubit extends Cubit<PatientState> {
  final PatientRepo patientRepo;
  late final String role;

  PatientCubit(this.patientRepo) : super(PatientInitial());

  void setRole(String role) {
    this.role = role;
  }
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


  static PatientCubit get(context) => BlocProvider.of(context);

  Future<void> patientSignUp()async {
    emit(SignUpLoadingState());
    print("patientSignUp called");
    try {
      var response = await patientRepo.patientSignUp(
        name: nameController.text,
        userName: userNameController.text,
        phone: phoneController.text,
        email: emailController.text,
        password: passwordController.text,
        role: role,
      );
      if(response.patient != null) {
      await StorageService.savePatient(response.patient!);
      }
      if(response.accessToken != null) {
        await StorageService.saveToken(response.accessToken!);
      }
      emit(SignUpSuccessState(message: response.message,patient: response.patient));
    } catch (e) {
      emit(SignUpErrorState(e.toString()));
    }
  }
}
