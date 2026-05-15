import 'package:chefaa/presentation/doctor/layout/home/data/repositories/clinic_repo.dart';
import 'package:chefaa/presentation/doctor/layout/home/data/models/Clinics.dart';
import 'package:chefaa/presentation/doctor/layout/home/presentation/manager/clinic_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClinicCubit  extends Cubit<ClinicState>{
  ClinicRepo clinicRepo;
  ClinicCubit(this.clinicRepo):super(ClinicInitialState());

  static ClinicCubit get(context)=> BlocProvider.of(context);

  Future<void> getClinicByID({required String clinicID}) async {
    emit(ClinicLoadingState());
    try {
      final response = await clinicRepo.getClinicByID(clinicID: clinicID);

      if (response.clinic == null) {
        emit(ClinicErrorState(message: "Clinic not found"));
        return;
      }

      emit(ClinicSuccessState(clinic: response.clinic!));
    } catch (e) {
      emit(ClinicErrorState(message: e.toString()));
    }
  }
  Future<void> getClinics({required String doctorID}) async {
    emit(ClinicLoadingState());
    try{
      final clinics = await clinicRepo.getClinics(doctorID: doctorID);
      emit(ClinicsSuccessState(clinics: clinics.clinics ?? const <Clinics>[]));
    }catch(e){
      emit(ClinicErrorState(message: e.toString()));
    }
  }


}