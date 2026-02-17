import 'package:chefaa/presentation/pharmacy/auth/presentation/manager/pharmacy_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/pharmacy_repo.dart';

@injectable
class PharmacyCubit extends Cubit<PharmacyState> {
  PharmacyRepo pharmacyRepo;

  PharmacyCubit(this.pharmacyRepo) : super(PharmacyInitial());

  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController registerNumber = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  static PharmacyCubit get(context) => BlocProvider.of(context);

  Future<void> pharmacySignUp({required PlatformFile? medicalLicence}) async {
    emit(PharmacyLoadingState());
    try {
      final response = await pharmacyRepo.pharmacySignUp(
        name: username.text,
        username: username.text,
        phoneNumber: phoneNumber.text,
        email: email.text,
        role: "pharmacy",
        password: password.text,
        medicalLicence: medicalLicence!,
        commercialRegisterNumber: registerNumber.text,
      );
      emit(PharmacySuccessState(response.pharmacy!, response.message!));
    } catch (e) {
      emit(PharmacyErrorState(e.toString()));
    }
  }
}
