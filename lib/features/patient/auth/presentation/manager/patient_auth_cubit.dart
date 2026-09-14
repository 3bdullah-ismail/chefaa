import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/services/storage_service.dart';
import 'package:chefaa/core/utils/username_generator.dart';
import 'package:chefaa/features/patient/auth/data/repositories/patient_auth_repo.dart';
import 'package:chefaa/features/patient/auth/presentation/manager/patient_auth_state.dart';
import 'package:chefaa/features/patient/home/presentation/manager/users_cubit.dart';

@injectable
class PatientAuthCubit extends Cubit<PatientAuthState> {
  final PatientRepo patientRepo;
  final UsersCubit usersCubit;

  PatientAuthCubit({required this.patientRepo, required this.usersCubit})
    : super(PatientInitial());

  static PatientAuthCubit get(BuildContext context) => BlocProvider.of(context);

  bool _isSigningUp = false;

  Future<void> patientSignUp({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    if (_isSigningUp) return;
    _isSigningUp = true;
    if (!isClosed) emit(SignUpLoadingState());

    try {
      final String fullName = "$firstName $lastName".trim();

      var response = await patientRepo.patientSignUp(
        name: fullName,
        userName: UsernameGenerator.generate(fullName),
        phone: phone,
        email: email,
        password: password,
        role: "patient",
      );

      if (response.user != null) {
        await StorageService.saveUser(response.user!);
      }
      if (response.accessToken != null) {
        await StorageService.saveToken(response.accessToken!);
      }

      await usersCubit.setUser(response);

      if (!isClosed) {
        emit(
          SignUpSuccessState(message: response.message, patient: response.user),
        );
      }
    } catch (e) {
      if (!isClosed) emit(SignUpErrorState(e.toString()));
    } finally {
      _isSigningUp = false;
    }
  }
}
