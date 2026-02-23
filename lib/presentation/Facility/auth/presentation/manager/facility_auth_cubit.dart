import 'package:chefaa/presentation/Facility/auth/data/repositories/repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'facility_auth_state.dart';

@injectable
class FacilityAuthCubit extends Cubit<FacilityAuthState> {
  FacilityAuthCubit(this.facilityRepo) : super(FacilityAuthInitial());
  FacilityAuthRepo facilityRepo;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController commercialRegisterNumber = TextEditingController();
  String? facilityType;

  TextEditingController medicalDirectorName = TextEditingController();
  TextEditingController directorProfessionalId = TextEditingController();
  TextEditingController specialization = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  static FacilityAuthCubit get(context) => BlocProvider.of(context);

  Future<void> signUp({required PlatformFile? medicalLicence}) async {
    if (medicalLicence == null) {
      emit(SingUpFailure("Please upload your membership file"));
      return;
    }
    emit(SignUpLoading());
    try {
      print(username.text);
      final response = await facilityRepo.signUP(
        name: name.text,
        username: username.text,
        email: email.text,
        password: password.text,
        commercialRegisterNumber: commercialRegisterNumber.text,
        facilityType: facilityType!.toLowerCase(),
        medicalDirectorName: medicalDirectorName.text,
        directorProfessionalId: directorProfessionalId.text,
        phoneNumber: phoneNumber.text,
        medicalLicence: medicalLicence,
      );
      emit(SingUpSuccess(userName: response.user!.name ?? ""));
    } catch (e) {
      emit(SingUpFailure(e.toString()));
    }
  }
}
