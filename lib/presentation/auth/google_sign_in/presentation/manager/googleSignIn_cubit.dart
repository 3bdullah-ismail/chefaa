import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/storage_service.dart';
import '../../data/repositories/googleSignIn_repo.dart';
import 'googleSignIn_state.dart';

@injectable
class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  final GoogleSignInRepo googleSignInRepo;

  GoogleSignInCubit(this.googleSignInRepo) : super(GoogleSignInInitial());

  static GoogleSignInCubit get(context) => BlocProvider.of(context);

  Future<void> signInWithGoogle(String idToken) async {
    emit(GoogleSignInLoadingState());

    try {
      final res = await googleSignInRepo.googleSignIn(idToken);

      await StorageService.saveToken(res.accessToken!);
      await StorageService.saveUser(res.user!);
      await StorageService.saveRole(res.user!.role!);

      emit(
        GoogleSignInSuccessState(
          user: res.user!,
          message: res.message ?? "Login successful",
        ),
      );
    } catch (e) {
      emit(GoogleSignInErrorState(e.toString()));
    }
  }
}
