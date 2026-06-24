import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/models/auth_response.dart';
import '../../../../../core/utils/username_generator.dart';
import '../../data/repositories/pharmacy_repo.dart';

part 'pharmacy_state.dart';

@injectable
class PharmacyCubit extends Cubit<PharmacyState> {
  PharmacyRepo pharmacyRepo;

  PharmacyCubit(this.pharmacyRepo) : super(PharmacyInitial());

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController registerNumber = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  static PharmacyCubit get(BuildContext context) => BlocProvider.of(context);

  bool _isSigningUp = false;

  Future<void> pharmacySignUp({required PlatformFile? medicalLicence}) async {
    if (_isSigningUp) return;
    _isSigningUp = true;
    emit(PharmacyLoadingState());
    try {
      final response = await pharmacyRepo.pharmacySignUp(
        name: name.text,
        username: UsernameGenerator.generate(name.text),
        phoneNumber: phoneNumber.text,
        email: email.text,
        role: "pharmacy",
        password: password.text,
        medicalLicence: medicalLicence!,
        commercialRegisterNumber: registerNumber.text,
      );
      emit(PharmacySuccessState(response.user!, response.message!));
    } catch (e) {
      emit(PharmacyErrorState(e.toString()));
    } finally {
      _isSigningUp = false;
    }
  }

  @override
  Future<void> close() {
    email.dispose();
    password.dispose();
    phoneNumber.dispose();
    registerNumber.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
