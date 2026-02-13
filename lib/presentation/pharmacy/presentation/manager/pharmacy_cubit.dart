import 'package:chefaa/presentation/pharmacy/data/repositories/pharmacy_repo.dart';
import 'package:chefaa/presentation/pharmacy/presentation/manager/pharmacy_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/widget/file_helper.dart';

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

  PlatformFile? medicalLicenceFile;

  static PharmacyCubit get(context) => BlocProvider.of(context);

  Future<void> pickFile() async {
    try {
      final file = await FileHelper.pickSingleFile();

      if (file != null) {
        medicalLicenceFile = file;
        emit(UploadMembershipState(file: file));
      } else {
        medicalLicenceFile = null;
        emit(UploadMembershipState(file: null));
      }
    } catch (e) {
      emit(PharmacyErrorState('Failed to pick file: $e'));
    }
  }

  Future<void> pharmacySignUp() async {
    emit(PharmacyLoadingState());
    try {
      final response = await pharmacyRepo.pharmacySignUp(
        name: username.text,
        username: username.text,
        phoneNumber: phoneNumber.text,
        email: email.text,
        role: "pharmacy",
        password: password.text,
        medicalLicence: medicalLicenceFile!,
        commercialRegisterNumber: registerNumber.text,
      );
      emit(PharmacySuccessState(response.pharmacy!, response.message!));
    } catch (e) {
      emit(PharmacyErrorState(e.toString()));
    }
  }
}
