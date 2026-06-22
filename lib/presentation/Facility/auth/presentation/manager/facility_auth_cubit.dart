import 'package:chefaa/presentation/facility/auth/domain/repositories/facility_auth_repo.dart';
import 'package:chefaa/presentation/facility/auth/domain/utils/username_generator.dart';
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
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController commercialRegisterNumber = TextEditingController();
  String? facilityType;
  TextEditingController medicalDirectorName = TextEditingController();
  TextEditingController directorProfessionalId = TextEditingController();
  TextEditingController specialization = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isSigningUp = false;

  static FacilityAuthCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> signUp({required PlatformFile? medicalLicence}) async {
    if (_isSigningUp) return;
    _isSigningUp = true;
    if (medicalLicence == null) {
      emit(SingUpFailure("Please upload your membership file"));
      _isSigningUp = false;
      return;
    }
    emit(SignUpLoading());
    try {
      final response = await facilityRepo.signUP(
        name: name.text,
        username: UsernameGenerator.generate(name.text),
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
    } finally {
      _isSigningUp = false;
    }
  }

  @override
  Future<void> close() {
    name.dispose();
    email.dispose();
    password.dispose();
    phoneNumber.dispose();
    commercialRegisterNumber.dispose();
    medicalDirectorName.dispose();
    directorProfessionalId.dispose();
    specialization.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
