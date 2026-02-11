import 'package:chefaa/core/widget/file_helper.dart';
import 'package:chefaa/presentation/doctor/auth/data/repositories/repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'doctor_auth_state.dart';

@injectable
class DoctorAuthCubit extends Cubit<DoctorAuthState> {
  DoctorAuthRepo doctorAuthRepo;
  DoctorAuthCubit(this.doctorAuthRepo) : super(DoctorAuthInitial());
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController specialization = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  static DoctorAuthCubit get(context) => BlocProvider.of(context);
  PlatformFile? membershipFile;

  Future<void> pickFile() async {
    try {
      final file = await FileHelper.pickSingleFile();

      if (file != null) {
        membershipFile = file;
        emit(UploadMembershipState(file: file));
      } else {
        membershipFile = null;
        emit(UploadMembershipState(file: null));
      }
    } catch (e) {
      emit(SingUpFailure('Failed to pick file: $e'));
    }
  }

  Future<void> signUp() async {
    print("object");
    emit(SingUpLoading());
    try {
      print(username.text);
      final response = await doctorAuthRepo.signUp(
        name: name.text,
        email: email.text,
        username: username.text,
        password: password.text,
        phoneNumber: phoneNumber.text,
        specialization: specialization.text,
        membership: membershipFile!,
      );

      emit(SingUpSuccess(userName: response.user!.name ?? ""));
    } catch (e) {
      emit(SingUpFailure(e.toString()));
    }
  }
}
