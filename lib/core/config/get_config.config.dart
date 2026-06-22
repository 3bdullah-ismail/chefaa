import 'package:chefaa/core/services/network_service.dart' as i492;
import 'package:chefaa/presentation/auth/data/data_sources/data_source.dart'
    as i339;
import 'package:chefaa/presentation/auth/data/data_sources/data_source_imp.dart'
    as i81;
import 'package:chefaa/presentation/auth/data/repositories/repo.dart' as i216;
import 'package:chefaa/presentation/auth/data/repositories/repo_imp.dart'
    as i63;
import 'package:chefaa/presentation/auth/presentation/manager/auth_cubit.dart'
    as i23;
import 'package:chefaa/presentation/doctor/auth/data/data_sources/data_source.dart'
    as i13;
import 'package:chefaa/presentation/doctor/auth/data/data_sources/data_source_imp.dart'
    as i875;
import 'package:chefaa/presentation/doctor/auth/data/repositories/repo.dart'
    as i260;
import 'package:chefaa/presentation/doctor/auth/data/repositories/repo_imp.dart'
    as i969;
import 'package:chefaa/presentation/doctor/auth/presentation/manager/doctor_auth_cubit.dart'
    as i677;
import 'package:chefaa/presentation/doctor/layout/home/data/data_sources/clinic_data_source.dart'
    as i465;
import 'package:chefaa/presentation/doctor/layout/home/data/data_sources/clinic_data_source_imp.dart'
    as i863;
import 'package:chefaa/presentation/doctor/layout/home/data/repositories/clinic_repo.dart'
    as i426;
import 'package:chefaa/presentation/doctor/layout/home/data/repositories/clinic_repo_imp.dart'
    as i210;
import 'package:chefaa/presentation/doctor/layout/home/presentation/manager/clinic_cubit.dart'
    as i819;
import 'package:chefaa/presentation/doctor/layout/patients/data/data_sources/patients_data_source_imp.dart'
    as i535;
import 'package:chefaa/presentation/doctor/layout/patients/data/data_sources/patients_data_sourse.dart'
    as i126;
import 'package:chefaa/presentation/doctor/layout/patients/data/repositories/patients_repo.dart'
    as i154;
import 'package:chefaa/presentation/doctor/layout/patients/data/repositories/patients_repo_imp.dart'
    as i312;
import 'package:chefaa/presentation/doctor/layout/patients/presentation/manager/patients_cubit.dart'
    as i57;
import 'package:chefaa/presentation/doctor/profile/data/data_sources/local_data_source/doctor_profile_local_data_source.dart'
    as i945;
import 'package:chefaa/presentation/doctor/profile/data/data_sources/local_data_source/doctor_profile_local_data_source_imp.dart'
    as i66;
import 'package:chefaa/presentation/doctor/profile/data/data_sources/remote_data_source/remote_data_source.dart'
    as i598;
import 'package:chefaa/presentation/doctor/profile/data/data_sources/remote_data_source/remote_data_source_imp.dart'
    as i5;
import 'package:chefaa/presentation/doctor/profile/data/repositories/doctor_profile_repo_impl.dart'
    as i962;
import 'package:chefaa/presentation/doctor/profile/domain/repositories/doctor_profile_repo.dart'
    as i440;
import 'package:chefaa/presentation/doctor/profile/domain/use_cases/get_doctor_data_use_case.dart'
    as i249;
import 'package:chefaa/presentation/doctor/profile/domain/use_cases/update_doctor_data_use_case.dart'
    as i722;
import 'package:chefaa/presentation/doctor/profile/presentation/manager/doctor_profile_cubit.dart'
    as i248;
import 'package:chefaa/presentation/facility/auth/data/data_sources/facility_auth_source.dart'
    as i60;
import 'package:chefaa/presentation/facility/auth/data/data_sources/facility_auth_source_imp.dart'
    as i29;
import 'package:chefaa/presentation/facility/auth/data/repositories/facility_auth_repo_imp.dart'
    as i221;
import 'package:chefaa/presentation/facility/auth/domain/repositories/facility_auth_repo.dart'
    as i336;
import 'package:chefaa/presentation/facility/auth/presentation/manager/facility_auth_cubit.dart'
    as i470;
import 'package:chefaa/presentation/patient/ai_lab/data/datasources/ai_report_data_source.dart'
    as i564;
import 'package:chefaa/presentation/patient/ai_lab/data/datasources/ai_report_data_source_imp.dart'
    as i1062;
import 'package:chefaa/presentation/patient/ai_lab/data/repositories/ai_report_repo.dart'
    as i17;
import 'package:chefaa/presentation/patient/ai_lab/data/repositories/ai_report_repo_imp.dart'
    as i88;
import 'package:chefaa/presentation/patient/ai_lab/presentation/manager/ai_report_cubit.dart'
    as i366;
import 'package:chefaa/presentation/patient/appointment/data/data_sources/appointment_remote_data_source.dart'
    as i532;
import 'package:chefaa/presentation/patient/appointment/data/data_sources/appointment_remote_data_source_impl.dart'
    as i538;
import 'package:chefaa/presentation/patient/appointment/data/repositories/appointment_repo.dart'
    as i178;
import 'package:chefaa/presentation/patient/appointment/data/repositories/appointment_repo_impl.dart'
    as i1047;
import 'package:chefaa/presentation/patient/appointment/presentation/manager/appointment_cubit.dart'
    as i522;
import 'package:chefaa/presentation/patient/auth/data/data_sources/patient_data_source.dart'
    as i597;
import 'package:chefaa/presentation/patient/auth/data/data_sources/patient_data_source_imp.dart'
    as i708;
import 'package:chefaa/presentation/patient/auth/data/repositories/patient_repo.dart'
    as i212;
import 'package:chefaa/presentation/patient/auth/data/repositories/patient_repo_imp.dart'
    as i473;
import 'package:chefaa/presentation/patient/auth/presentation/manager/patient_cubit.dart'
    as i556;
import 'package:chefaa/presentation/patient/booking/data/data_sources/remote_date_source/remote_data_source.dart'
    as i352;
import 'package:chefaa/presentation/patient/booking/data/data_sources/remote_date_source/remote_data_source_impl.dart'
    as i369;
import 'package:chefaa/presentation/patient/booking/data/repositories/booking_repo.dart'
    as i598;
import 'package:chefaa/presentation/patient/booking/data/repositories/booking_repo_imp.dart'
    as i501;
import 'package:chefaa/presentation/patient/booking/presentation/manager/booking_cubit.dart'
    as i1055;
import 'package:chefaa/presentation/patient/chatbot/data/data_sources/chatbot_remote_data_source.dart'
    as i231;
import 'package:chefaa/presentation/patient/chatbot/data/data_sources/chatbot_remote_data_source_imp.dart'
    as i998;
import 'package:chefaa/presentation/patient/chatbot/data/repositories/chatbot_repo.dart'
    as i989;
import 'package:chefaa/presentation/patient/chatbot/data/repositories/chatbot_repo_imp.dart'
    as i350;
import 'package:chefaa/presentation/patient/chatbot/presentation/manager/chatbot_cubit.dart'
    as i821;
import 'package:chefaa/presentation/patient/complete_auth_data/data/data_sources/complete_data_source.dart'
    as i1028;
import 'package:chefaa/presentation/patient/complete_auth_data/data/data_sources/complete_data_source_imp.dart'
    as i450;
import 'package:chefaa/presentation/patient/complete_auth_data/data/repositories/complete_patient_repo.dart'
    as i695;
import 'package:chefaa/presentation/patient/complete_auth_data/data/repositories/complete_patient_repo_imp.dart'
    as i801;
import 'package:chefaa/presentation/patient/complete_auth_data/presentation/manager/complete_cubit.dart'
    as i40;
import 'package:chefaa/presentation/patient/home/data/data_sources/home_data_source.dart'
    as i67;
import 'package:chefaa/presentation/patient/home/data/data_sources/home_data_source_imp.dart'
    as i325;
import 'package:chefaa/presentation/patient/home/data/repositories/home_repo.dart'
    as i1070;
import 'package:chefaa/presentation/patient/home/data/repositories/home_repo_imp.dart'
    as i1025;
import 'package:chefaa/presentation/patient/home/data/users_domain/domain/user_usecase.dart'
    as i778;
import 'package:chefaa/presentation/patient/home/presentation/manager/users_cubit.dart'
    as i508;
import 'package:chefaa/presentation/patient/medication/data/data_sources/medication_data_source.dart'
    as i775;
import 'package:chefaa/presentation/patient/medication/data/data_sources/medication_data_source_imp.dart'
    as i646;
import 'package:chefaa/presentation/patient/medication/data/repositories/medication_repo.dart'
    as i145;
import 'package:chefaa/presentation/patient/medication/data/repositories/medication_repo_imp.dart'
    as i602;
import 'package:chefaa/presentation/patient/medication/presentation/manager/medication_cubit.dart'
    as i761;
import 'package:chefaa/presentation/patient/profile/data/data_sources/remote_date_source/profile_remote_data_source.dart'
    as i723;
import 'package:chefaa/presentation/patient/profile/data/data_sources/remote_date_source/profile_remote_data_source_imp.dart'
    as i819;
import 'package:chefaa/presentation/patient/profile/data/repositories/profile_repo.dart'
    as i229;
import 'package:chefaa/presentation/patient/profile/data/repositories/profile_repo_imp.dart'
    as i851;
import 'package:chefaa/presentation/patient/profile/presentation/manager/profile_cubit.dart'
    as i105;
import 'package:chefaa/presentation/patient/search/data/data_sources/local_data_source/search_local_data_source.dart'
    as i233;
import 'package:chefaa/presentation/patient/search/data/data_sources/local_data_source/search_local_data_source_imp.dart'
    as i617;
import 'package:chefaa/presentation/patient/search/data/data_sources/remote_data_source/search_remote_data_source.dart'
    as i169;
import 'package:chefaa/presentation/patient/search/data/data_sources/remote_data_source/search_remote_data_source_imp.dart'
    as i623;
import 'package:chefaa/presentation/patient/search/data/repositories/search_repo_imp.dart'
    as i331;
import 'package:chefaa/presentation/patient/search/domain/repositories/search_repo.dart'
    as i483;
import 'package:chefaa/presentation/patient/search/presentation/manager/search_cubit.dart'
    as i952;
import 'package:chefaa/presentation/pharmacy/auth/data/data_sources/pharmacy_data_source.dart'
    as i831;
import 'package:chefaa/presentation/pharmacy/auth/data/data_sources/pharmacy_data_source_imp.dart'
    as i440;
import 'package:chefaa/presentation/pharmacy/auth/data/repositories/pharmacy_repo.dart'
    as i235;
import 'package:chefaa/presentation/pharmacy/auth/data/repositories/pharmacy_repo_imp.dart'
    as i71;
import 'package:chefaa/presentation/pharmacy/auth/presentation/manager/pharmacy_cubit.dart'
    as i779;
import 'package:get_it/get_it.dart' as i174;
import 'package:injectable/injectable.dart' as i526;

extension GetItInjectableX on i174.GetIt {
  i174.GetIt init({
    String? environment,
    i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<i778.UserUseCase>(() => i778.UserUseCase());
    gh.lazySingleton<i492.NetworkService>(() => i492.NetworkService());
    gh.factory<i945.DoctorProfileLocalDataSource>(
      () => i66.DoctorProfileLocalDataSourceImp(),
    );
    gh.factory<i233.SearchLocalDataSource>(
      () => i617.SearchDoctorLocalDataSourceImp(),
    );
    gh.factory<i352.BookingRemoteDataSource>(
      () => i369.BookingRemoteDataSourceImpl(gh<i492.NetworkService>()),
    );
    gh.factory<i465.ClinicDataSource>(
      () => i863.ClinicDataSourceImp(gh<i492.NetworkService>()),
    );
    gh.factory<i723.ProfileRemoteDataSource>(
      () => i819.ProfileRemoteDataSourceImpl(gh<i492.NetworkService>()),
    );
    gh.factory<i831.PharmacyDataSource>(
      () =>
          i440.PharmacyDataSourceImp(networkService: gh<i492.NetworkService>()),
    );
    gh.factory<i126.PatientsDataSource>(
      () => i535.PatientsDataSourceImp(gh<i492.NetworkService>()),
    );
    gh.factory<i508.UsersCubit>(() => i508.UsersCubit(gh<i778.UserUseCase>()));
    gh.factory<i775.MedicationDataSource>(
      () => i646.MedicationDataSourceImp(gh<i492.NetworkService>()),
    );
    gh.factory<i564.AIReportDataSource>(
      () => i1062.AIReportDataSourceImp(gh<i492.NetworkService>()),
    );
    gh.factory<i597.PatientDataSource>(
      () => i708.PatientDataSourceImp(gh<i492.NetworkService>()),
    );
    gh.factory<i169.SearchRemoteDataSource>(
      () => i623.SearchDataSourceImp(gh<i492.NetworkService>()),
    );
    gh.factory<i532.AppointmentRemoteDataSource>(
      () => i538.AppointmentRemoteDataSourceImpl(gh<i492.NetworkService>()),
    );
    gh.factory<i145.MedicationRepo>(
      () => i602.MedicationRepoImp(gh<i775.MedicationDataSource>()),
    );
    gh.factory<i154.PatientsRepo>(
      () => i312.PatientsRepoImp(gh<i126.PatientsDataSource>()),
    );
    gh.factory<i17.AIReportRepo>(
      () => i88.AiReportRepoImp(gh<i564.AIReportDataSource>()),
    );
    gh.factory<i366.AiReportCubit>(
      () => i366.AiReportCubit(gh<i17.AIReportRepo>()),
    );
    gh.factory<i231.ChatbotRemoteDataSource>(
      () => i998.ChatbotRemoteDataSourceImp(gh<i492.NetworkService>()),
    );
    gh.factory<i598.DoctorProfileRemoteDataSource>(
      () => i5.DoctorProfileRemoteDataSourceImp(gh<i492.NetworkService>()),
    );
    gh.factory<i13.DoctorAuthDataSource>(
      () => i875.DoctorAuthDataSourceImp(gh<i492.NetworkService>()),
    );
    gh.factory<i339.AuthDataSource>(
      () => i81.AuthDataSourceImp(gh<i492.NetworkService>()),
    );
    gh.factory<i178.AppointmentRepo>(
      () => i1047.AppointmentRepoImpl(gh<i532.AppointmentRemoteDataSource>()),
    );
    gh.factory<i67.HomeDataSource>(
      () => i325.HomeDataSourceImp(gh<i492.NetworkService>()),
    );
    gh.factory<i60.FacilityAuthDataSource>(
      () => i29.FacilityAuthDataSourceImp(gh<i492.NetworkService>()),
    );
    gh.factory<i1028.CompleteDataSource>(
      () =>
          i450.CompleteDataSourceImp(networkService: gh<i492.NetworkService>()),
    );
    gh.factory<i212.PatientRepo>(
      () => i473.PatientRepoImp(gh<i597.PatientDataSource>()),
    );
    gh.factory<i426.ClinicRepo>(
      () => i210.ClinicRepoImp(gh<i465.ClinicDataSource>()),
    );
    gh.factory<i695.CompletePatientRepo>(
      () => i801.CompletePatientRepoImp(
        completeDataSource: gh<i1028.CompleteDataSource>(),
      ),
    );
    gh.factory<i235.PharmacyRepo>(
      () => i71.PharmacyRepoImp(
        pharmacyDataSource: gh<i831.PharmacyDataSource>(),
      ),
    );
    gh.factory<i598.BookingRepo>(
      () => i501.BookingRepoImp(gh<i352.BookingRemoteDataSource>()),
    );
    gh.factory<i57.PatientsCubit>(
      () => i57.PatientsCubit(gh<i154.PatientsRepo>()),
    );
    gh.factory<i40.CompleteCubit>(
      () => i40.CompleteCubit(gh<i695.CompletePatientRepo>()),
    );
    gh.factory<i761.MedicationCubit>(
      () => i761.MedicationCubit(gh<i145.MedicationRepo>()),
    );
    gh.factory<i260.DoctorAuthRepo>(
      () => i969.DoctorAuthRepoImp(gh<i13.DoctorAuthDataSource>()),
    );
    gh.factory<i819.ClinicCubit>(() => i819.ClinicCubit(gh<i426.ClinicRepo>()));
    gh.factory<i556.PatientCubit>(
      () => i556.PatientCubit(
        patientRepo: gh<i212.PatientRepo>(),
        usersCubit: gh<i508.UsersCubit>(),
      ),
    );
    gh.factory<i336.FacilityAuthRepo>(
      () => i221.FacilityRepoImp(gh<i60.FacilityAuthDataSource>()),
    );
    gh.factory<i229.ProfileRepo>(
      () => i851.ProfileRepoImpl(gh<i723.ProfileRemoteDataSource>()),
    );
    gh.factory<i470.FacilityAuthCubit>(
      () => i470.FacilityAuthCubit(gh<i336.FacilityAuthRepo>()),
    );
    gh.factory<i216.AuthRepo>(() => i63.AuthRepoImp(gh<i339.AuthDataSource>()));
    gh.factory<i989.ChatbotRepo>(
      () => i350.ChatbotRepoImp(gh<i231.ChatbotRemoteDataSource>()),
    );
    gh.factory<i483.SearchRepo>(
      () => i331.SearchRepoImp(
        gh<i169.SearchRemoteDataSource>(),
        gh<i233.SearchLocalDataSource>(),
      ),
    );
    gh.factory<i952.SearchCubit>(() => i952.SearchCubit(gh<i483.SearchRepo>()));
    gh.factory<i522.AppointmentCubit>(
      () => i522.AppointmentCubit(gh<i178.AppointmentRepo>()),
    );
    gh.factory<i440.DoctorProfileRepo>(
      () => i962.DoctorProfileRepoImpl(
        gh<i598.DoctorProfileRemoteDataSource>(),
        gh<i945.DoctorProfileLocalDataSource>(),
      ),
    );
    gh.factory<i821.ChatbotCubit>(
      () => i821.ChatbotCubit(gh<i989.ChatbotRepo>()),
    );
    gh.factory<i1055.BookingCubit>(
      () => i1055.BookingCubit(gh<i598.BookingRepo>()),
    );
    gh.factory<i1070.HomeRepo>(
      () => i1025.HomeRepoImp(gh<i67.HomeDataSource>()),
    );
    gh.factory<i779.PharmacyCubit>(
      () => i779.PharmacyCubit(gh<i235.PharmacyRepo>()),
    );
    gh.factory<i23.AuthCubit>(
      () => i23.AuthCubit(
        repo: gh<i216.AuthRepo>(),
        usersCubit: gh<i508.UsersCubit>(),
      ),
    );
    gh.factory<i249.GetDoctorDataUseCase>(
      () => i249.GetDoctorDataUseCase(gh<i440.DoctorProfileRepo>()),
    );
    gh.factory<i722.UpdateDoctorDataUseCase>(
      () => i722.UpdateDoctorDataUseCase(gh<i440.DoctorProfileRepo>()),
    );
    gh.factory<i248.DoctorProfileCubit>(
      () => i248.DoctorProfileCubit(
        getDoctorDataUseCase: gh<i249.GetDoctorDataUseCase>(),
        updateDoctorDataUseCase: gh<i722.UpdateDoctorDataUseCase>(),
      ),
    );
    gh.factory<i105.ProfileCubit>(
      () => i105.ProfileCubit(gh<i229.ProfileRepo>()),
    );
    gh.factory<i677.DoctorAuthCubit>(
      () => i677.DoctorAuthCubit(
        doctorAuthRepo: gh<i260.DoctorAuthRepo>(),
        usersCubit: gh<i508.UsersCubit>(),
      ),
    );
    return this;
  }
}
