import 'package:chefaa/presentation/doctor/layout/patients/data/repositories/patients_repo.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/manager/patients_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PatientsCubit extends Cubit<PatientsState> {
  final PatientsRepo patientsRepo;

  PatientsCubit(this.patientsRepo) : super(PatientsInitialState());
  static PatientsCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getPatients() async {
    emit(PatientsLoadingState());

    try {
      final patients = await patientsRepo.getPatients();

      final upcoming = patients.where((e) => e.status == "upcoming").toList();

      final completed = patients.where((e) => e.status == "completed").toList();

      emit(PatientsSuccessState(upcoming: upcoming, completed: completed));
    } catch (e) {
      emit(PatientsFailureState(e.toString()));
    }
  }

  void changeTab(int index) {
    final currentState = state;

    if (currentState is PatientsSuccessState) {
      emit(currentState.copyWith(selectedIndex: index));
    }
  }
}
