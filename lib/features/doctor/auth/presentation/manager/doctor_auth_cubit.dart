import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/services/storage_service.dart';
import 'package:chefaa/core/utils/username_generator.dart';
import 'package:chefaa/features/doctor/auth/data/repositories/doctor_auth_repo.dart';
import 'package:chefaa/features/patient/home/presentation/manager/users_cubit.dart';

part 'doctor_auth_state.dart';

@injectable
class DoctorAuthCubit extends Cubit<DoctorAuthState> {
  DoctorAuthRepo doctorAuthRepo;

  bool _isSigningUp = false;

  final UsersCubit usersCubit;

  static DoctorAuthCubit get(BuildContext context) => BlocProvider.of(context);

  DoctorAuthCubit({required this.doctorAuthRepo, required this.usersCubit})
    : super(DoctorAuthInitial());

  DoctorAuthCubit.initial({
    required this.doctorAuthRepo,
    required this.usersCubit,
  }) : super(DoctorAuthInitial());

  Future<void> signUp({
    required PlatformFile? membershipFile,
    required String name,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required String specialization,
  }) async {
    if (_isSigningUp) return;
    _isSigningUp = true;
    if (membershipFile == null) {
      if (!isClosed) emit(SingUpFailure("Please upload your membership file"));
      _isSigningUp = false;
      return;
    }
    if (!isClosed) emit(SingUpLoading());
    try {
      final String fullName = "$name $lastName".trim();
      final response = await doctorAuthRepo.signUp(
        name: fullName,
        email: email,
        username: UsernameGenerator.generate(fullName),
        password: password,
        phoneNumber: phoneNumber,
        specialization: specialization,
        membership: membershipFile,
      );
      if (response.user != null) {
        await StorageService.saveUser(response.user!);
      }
      if (response.accessToken != null) {
        await StorageService.saveToken(response.accessToken!);
      }
      await usersCubit.setUser(response);
      if (!isClosed) emit(SingUpSuccess(userName: response.user?.name ?? ""));
    } catch (e) {
      if (!isClosed) emit(SingUpFailure(e.toString()));
    } finally {
      _isSigningUp = false;
    }
  }
}
