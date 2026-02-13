import 'package:chefaa/presentation/patient/complete_auth_data/data/repositories/complete_patient_repo.dart';
import 'package:chefaa/presentation/patient/complete_auth_data/presentation/manager/complete_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompleteCubit extends Cubit<CompleteState> {
  late final double? weight;
  late final int? height;
  late final String bloodType;
  late final String? gender;
  late final DateTime? birthDate;
  late final List<String> chronicDiseases = [];

  CompletePatientRepo completePatientRepo;
  CompleteCubit(this.completePatientRepo) : super(CompleteInitial());

  List<String> allergies = [];


  static CompleteCubit get(context) => BlocProvider.of(context);

  void AllData( double? weight,
  int? height,
  String? bloodType,
  String? gender,
  DateTime? birthDate,
  List<String> chronicDiseases ) {
    this.weight = weight;
    this.height = height;
    this.bloodType = bloodType!;
    this.gender = gender;
    this.birthDate = birthDate;
    this.chronicDiseases.addAll(chronicDiseases);
  }

  Future<void> CompleteSignUp() async {
    emit(CompleteLoadingState());
    try {
      int age = birthDate != null ? calculateAge(birthDate!) : 0;
      final response = await completePatientRepo.completeSignUp(
        weight: weight!,
        height: height!,
        bloodType: bloodType,
        gender: gender,
       age: age,
        chronicDiseases: chronicDiseases,
        allergies: allergies,
      );
      emit(
        CompleteSuccessState(
          message: response.message,
          patient: response.patient,
        ),
      );
    } catch (e) {
      emit(CompleteErrorState(e.toString()));
    }
  }
  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

}
