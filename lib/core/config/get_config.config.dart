// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chefaa/core/services/network_service.dart' as _i492;
import 'package:chefaa/presentation/auth/data/data_sources/data_source.dart'
    as _i339;
import 'package:chefaa/presentation/auth/data/data_sources/data_source_imp.dart'
    as _i81;
import 'package:chefaa/presentation/auth/data/repositories/repo.dart' as _i216;
import 'package:chefaa/presentation/auth/data/repositories/repo_imp.dart'
    as _i63;
import 'package:chefaa/presentation/auth/presentation/manager/auth_cubit.dart'
    as _i23;
import 'package:chefaa/presentation/doctor/auth/data/data_sources/data_source.dart'
    as _i13;
import 'package:chefaa/presentation/doctor/auth/data/data_sources/data_source_imp.dart'
    as _i875;
import 'package:chefaa/presentation/doctor/auth/data/repositories/repo.dart'
    as _i260;
import 'package:chefaa/presentation/doctor/auth/data/repositories/repo_imp.dart'
    as _i969;
import 'package:chefaa/presentation/doctor/auth/presentation/manager/doctor_auth_cubit.dart'
    as _i677;
import 'package:chefaa/presentation/doctor/layout/home/data/data_sources/clinic_data_source.dart'
    as _i465;
import 'package:chefaa/presentation/doctor/layout/home/data/data_sources/clinic_data_source_imp.dart'
    as _i863;
import 'package:chefaa/presentation/doctor/layout/home/data/repositories/clinic_repo.dart'
    as _i426;
import 'package:chefaa/presentation/doctor/layout/home/data/repositories/clinic_repo_imp.dart'
    as _i210;
import 'package:chefaa/presentation/doctor/layout/home/presentation/manager/clinic_cubit.dart'
    as _i819;
import 'package:chefaa/presentation/doctor/profile/data/data_sources/local_data_source/doctor_profile_local_data_source.dart'
    as _i945;
import 'package:chefaa/presentation/doctor/profile/data/data_sources/local_data_source/doctor_profile_local_data_source_imp.dart'
    as _i66;
import 'package:chefaa/presentation/doctor/profile/data/data_sources/remote_data_source/remote_data_source.dart'
    as _i598;
import 'package:chefaa/presentation/doctor/profile/data/data_sources/remote_data_source/remote_data_source_imp.dart'
    as _i5;
import 'package:chefaa/presentation/doctor/profile/data/repositories/doctor_profile_repo_impl.dart'
    as _i962;
import 'package:chefaa/presentation/doctor/profile/domain/repositories/doctor_profile_repo.dart'
    as _i440;
import 'package:chefaa/presentation/doctor/profile/domain/use_cases/get_doctor_data_use_case.dart'
    as _i249;
import 'package:chefaa/presentation/doctor/profile/domain/use_cases/update_doctor_data_use_case.dart'
    as _i722;
import 'package:chefaa/presentation/doctor/profile/presentation/manager/doctor_profile_cubit.dart'
    as _i248;
import 'package:chefaa/presentation/Facility/auth/data/data_sources/facility_auth_source.dart'
    as _i60;
import 'package:chefaa/presentation/Facility/auth/data/data_sources/facility_auth_source_imp.dart'
    as _i29;
import 'package:chefaa/presentation/Facility/auth/data/repositories/facility_auth_repo_imp.dart'
    as _i221;
import 'package:chefaa/presentation/Facility/auth/domain/repositories/facility_auth_repo.dart'
    as _i336;
import 'package:chefaa/presentation/Facility/auth/presentation/manager/facility_auth_cubit.dart'
    as _i470;
import 'package:chefaa/presentation/patient/ai_lab/data/datasources/ai_report_data_source.dart'
    as _i564;
import 'package:chefaa/presentation/patient/ai_lab/data/datasources/ai_report_data_source_imp.dart'
    as _i1062;
import 'package:chefaa/presentation/patient/ai_lab/data/repositories/ai_report_repo.dart'
    as _i17;
import 'package:chefaa/presentation/patient/ai_lab/data/repositories/ai_report_repo_imp.dart'
    as _i88;
import 'package:chefaa/presentation/patient/ai_lab/presentation/manager/ai_report_cubit.dart'
    as _i366;
import 'package:chefaa/presentation/patient/auth/data/data_sources/patient_data_source.dart'
    as _i597;
import 'package:chefaa/presentation/patient/auth/data/data_sources/patient_data_source_imp.dart'
    as _i708;
import 'package:chefaa/presentation/patient/auth/data/repositories/patient_repo.dart'
    as _i212;
import 'package:chefaa/presentation/patient/auth/data/repositories/patient_repo_imp.dart'
    as _i473;
import 'package:chefaa/presentation/patient/auth/presentation/manager/patient_cubit.dart'
    as _i556;
import 'package:chefaa/presentation/patient/booking/data/data_sources/remote_date_source/remote_data_source.dart'
    as _i352;
import 'package:chefaa/presentation/patient/booking/data/data_sources/remote_date_source/remote_data_source_impl.dart'
    as _i369;
import 'package:chefaa/presentation/patient/chatbot/data/data_sources/chatbot_remote_data_source.dart'
    as _i231;
import 'package:chefaa/presentation/patient/chatbot/data/data_sources/chatbot_remote_data_source_imp.dart'
    as _i998;
import 'package:chefaa/presentation/patient/chatbot/data/repositories/chatbot_repo.dart'
    as _i989;
import 'package:chefaa/presentation/patient/chatbot/data/repositories/chatbot_repo_imp.dart'
    as _i350;
import 'package:chefaa/presentation/patient/chatbot/presentation/manager/chatbot_cubit.dart'
    as _i821;
import 'package:chefaa/presentation/patient/complete_auth_data/data/data_sources/complete_data_source.dart'
    as _i1028;
import 'package:chefaa/presentation/patient/complete_auth_data/data/data_sources/complete_data_source_imp.dart'
    as _i450;
import 'package:chefaa/presentation/patient/complete_auth_data/data/repositories/complete_patient_repo.dart'
    as _i695;
import 'package:chefaa/presentation/patient/complete_auth_data/data/repositories/complete_patient_repo_imp.dart'
    as _i801;
import 'package:chefaa/presentation/patient/complete_auth_data/presentation/manager/complete_cubit.dart'
    as _i40;
import 'package:chefaa/presentation/patient/home/data/data_sources/home_data_source.dart'
    as _i67;
import 'package:chefaa/presentation/patient/home/data/data_sources/home_data_source_imp.dart'
    as _i325;
import 'package:chefaa/presentation/patient/home/data/repositories/home_repo.dart'
    as _i1070;
import 'package:chefaa/presentation/patient/home/data/repositories/home_repo_imp.dart'
    as _i1025;
import 'package:chefaa/presentation/patient/home/data/users_domain/domain/user_usecase.dart'
    as _i778;
import 'package:chefaa/presentation/patient/home/presentation/manager/users_cubit.dart'
    as _i508;
import 'package:chefaa/presentation/patient/medication/data/data_sources/medication_data_source.dart'
    as _i775;
import 'package:chefaa/presentation/patient/medication/data/data_sources/medication_data_source_imp.dart'
    as _i646;
import 'package:chefaa/presentation/patient/medication/data/repositories/medication_repo.dart'
    as _i145;
import 'package:chefaa/presentation/patient/medication/data/repositories/medication_repo_imp.dart'
    as _i602;
import 'package:chefaa/presentation/patient/medication/presentation/manager/medication_cubit.dart'
    as _i761;
import 'package:chefaa/presentation/patient/profile/data/data_sources/remote_date_source/profile_remote_data_source.dart'
    as _i723;
import 'package:chefaa/presentation/patient/profile/data/data_sources/remote_date_source/profile_remote_data_source_imp.dart'
    as _i819;
import 'package:chefaa/presentation/patient/profile/data/repositories/profile_repo.dart'
    as _i229;
import 'package:chefaa/presentation/patient/profile/data/repositories/profile_repo_imp.dart'
    as _i851;
import 'package:chefaa/presentation/patient/profile/presentation/manager/profile_cubit.dart'
    as _i105;
import 'package:chefaa/presentation/patient/search/data/data_sources/local_data_source/search_local_data_source.dart'
    as _i233;
import 'package:chefaa/presentation/patient/search/data/data_sources/local_data_source/search_local_data_source_imp.dart'
    as _i617;
import 'package:chefaa/presentation/patient/search/data/data_sources/remote_data_source/search_remote_data_source.dart'
    as _i169;
import 'package:chefaa/presentation/patient/search/data/data_sources/remote_data_source/search_remote_data_source_imp.dart'
    as _i623;
import 'package:chefaa/presentation/patient/search/data/repositories/search_repo_imp.dart'
    as _i331;
import 'package:chefaa/presentation/patient/search/domain/repositories/search_repo.dart'
    as _i483;
import 'package:chefaa/presentation/patient/search/presentation/manager/search_cubit.dart'
    as _i952;
import 'package:chefaa/presentation/pharmacy/auth/data/data_sources/pharmacy_data_source.dart'
    as _i831;
import 'package:chefaa/presentation/pharmacy/auth/data/data_sources/pharmacy_data_source_imp.dart'
    as _i440;
import 'package:chefaa/presentation/pharmacy/auth/data/repositories/pharmacy_repo.dart'
    as _i235;
import 'package:chefaa/presentation/pharmacy/auth/data/repositories/pharmacy_repo_imp.dart'
    as _i71;
import 'package:chefaa/presentation/pharmacy/auth/presentation/manager/pharmacy_cubit.dart'
    as _i779;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i778.UserUseCase>(() => _i778.UserUseCase());
    gh.lazySingleton<_i492.NetworkService>(() => _i492.NetworkService());
    gh.factory<_i945.DoctorProfileLocalDataSource>(
        () => _i66.DoctorProfileLocalDataSourceImp());
    gh.factory<_i233.SearchLocalDataSource>(
        () => _i617.SearchDoctorLocalDataSourceImp());
    gh.factory<_i352.BookingRemoteDataSource>(
        () => _i369.BookingRemoteDataSourceImpl(gh<_i492.NetworkService>()));
    gh.factory<_i465.ClinicDataSource>(
        () => _i863.ClinicDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i723.ProfileRemoteDataSource>(
        () => _i819.ProfileRemoteDataSourceImpl(gh<_i492.NetworkService>()));
    gh.factory<_i831.PharmacyDataSource>(() => _i440.PharmacyDataSourceImp(
        networkService: gh<_i492.NetworkService>()));
    gh.factory<_i508.UsersCubit>(
        () => _i508.UsersCubit(gh<_i778.UserUseCase>()));
    gh.factory<_i775.MedicationDataSource>(
        () => _i646.MedicationDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i564.AIReportDataSource>(
        () => _i1062.AIReportDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i597.PatientDataSource>(
        () => _i708.PatientDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i169.SearchRemoteDataSource>(
        () => _i623.SearchDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i145.MedicationRepo>(
        () => _i602.MedicationRepoImp(gh<_i775.MedicationDataSource>()));
    gh.factory<_i17.AIReportRepo>(
        () => _i88.AiReportRepoImp(gh<_i564.AIReportDataSource>()));
    gh.factory<_i366.AiReportCubit>(
        () => _i366.AiReportCubit(gh<_i17.AIReportRepo>()));
    gh.factory<_i231.ChatbotRemoteDataSource>(
        () => _i998.ChatbotRemoteDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i598.DoctorProfileRemoteDataSource>(
        () => _i5.DoctorProfileRemoteDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i13.DoctorAuthDataSource>(
        () => _i875.DoctorAuthDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i339.AuthDataSource>(
        () => _i81.AuthDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i67.HomeDataSource>(
        () => _i325.HomeDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i60.FacilityAuthDataSource>(
        () => _i29.FacilityAuthDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i1028.CompleteDataSource>(() => _i450.CompleteDataSourceImp(
        networkService: gh<_i492.NetworkService>()));
    gh.factory<_i212.PatientRepo>(
        () => _i473.PatientRepoImp(gh<_i597.PatientDataSource>()));
    gh.factory<_i426.ClinicRepo>(
        () => _i210.ClinicRepoImp(gh<_i465.ClinicDataSource>()));
    gh.factory<_i695.CompletePatientRepo>(() => _i801.CompletePatientRepoImp(
        completeDataSource: gh<_i1028.CompleteDataSource>()));
    gh.factory<_i235.PharmacyRepo>(() => _i71.PharmacyRepoImp(
        pharmacyDataSource: gh<_i831.PharmacyDataSource>()));
    gh.factory<_i40.CompleteCubit>(
        () => _i40.CompleteCubit(gh<_i695.CompletePatientRepo>()));
    gh.factory<_i761.MedicationCubit>(
        () => _i761.MedicationCubit(gh<_i145.MedicationRepo>()));
    gh.factory<_i260.DoctorAuthRepo>(
        () => _i969.DoctorAuthRepoImp(gh<_i13.DoctorAuthDataSource>()));
    gh.factory<_i819.ClinicCubit>(
        () => _i819.ClinicCubit(gh<_i426.ClinicRepo>()));
    gh.factory<_i556.PatientCubit>(() => _i556.PatientCubit(
          patientRepo: gh<_i212.PatientRepo>(),
          usersCubit: gh<_i508.UsersCubit>(),
        ));
    gh.factory<_i336.FacilityAuthRepo>(
        () => _i221.FacilityRepoImp(gh<_i60.FacilityAuthDataSource>()));
    gh.factory<_i229.ProfileRepo>(
        () => _i851.ProfileRepoImpl(gh<_i723.ProfileRemoteDataSource>()));
    gh.factory<_i470.FacilityAuthCubit>(
        () => _i470.FacilityAuthCubit(gh<_i336.FacilityAuthRepo>()));
    gh.factory<_i216.AuthRepo>(
        () => _i63.AuthRepoImp(gh<_i339.AuthDataSource>()));
    gh.factory<_i989.ChatbotRepo>(
        () => _i350.ChatbotRepoImp(gh<_i231.ChatbotRemoteDataSource>()));
    gh.factory<_i483.SearchRepo>(() => _i331.SearchRepoImp(
          gh<_i169.SearchRemoteDataSource>(),
          gh<_i233.SearchLocalDataSource>(),
        ));
    gh.factory<_i952.SearchCubit>(
        () => _i952.SearchCubit(gh<_i483.SearchRepo>()));
    gh.factory<_i440.DoctorProfileRepo>(() => _i962.DoctorProfileRepoImpl(
          gh<_i598.DoctorProfileRemoteDataSource>(),
          gh<_i945.DoctorProfileLocalDataSource>(),
        ));
    gh.factory<_i821.ChatbotCubit>(
        () => _i821.ChatbotCubit(gh<_i989.ChatbotRepo>()));
    gh.factory<_i1070.HomeRepo>(
        () => _i1025.HomeRepoImp(gh<_i67.HomeDataSource>()));
    gh.factory<_i779.PharmacyCubit>(
        () => _i779.PharmacyCubit(gh<_i235.PharmacyRepo>()));
    gh.factory<_i23.AuthCubit>(() => _i23.AuthCubit(
          repo: gh<_i216.AuthRepo>(),
          usersCubit: gh<_i508.UsersCubit>(),
        ));
    gh.factory<_i249.GetDoctorDataUseCase>(
        () => _i249.GetDoctorDataUseCase(gh<_i440.DoctorProfileRepo>()));
    gh.factory<_i722.UpdateDoctorDataUseCase>(
        () => _i722.UpdateDoctorDataUseCase(gh<_i440.DoctorProfileRepo>()));
    gh.factory<_i248.DoctorProfileCubit>(() => _i248.DoctorProfileCubit(
          getDoctorDataUseCase: gh<_i249.GetDoctorDataUseCase>(),
          updateDoctorDataUseCase: gh<_i722.UpdateDoctorDataUseCase>(),
        ));
    gh.factory<_i105.ProfileCubit>(
        () => _i105.ProfileCubit(gh<_i229.ProfileRepo>()));
    gh.factory<_i677.DoctorAuthCubit>(() => _i677.DoctorAuthCubit(
          doctorAuthRepo: gh<_i260.DoctorAuthRepo>(),
          usersCubit: gh<_i508.UsersCubit>(),
        ));
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i434.UserUseCase>(() => _i434.UserUseCase());
    gh.lazySingleton<_i463.NetworkService>(() => _i463.NetworkService());
    gh.factory<_i181.SearchLocalDataSource>(
        () => _i150.SearchDoctorLocalDataSourceImp());
    gh.factory<_i372.BookingRemoteDataSource>(
        () => _i1020.BookingRemoteDataSourceImpl(gh<_i463.NetworkService>()));
    gh.factory<_i808.ClinicDataSource>(
        () => _i637.ClinicDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i183.ProfileRemoteDataSource>(
        () => _i1047.ProfileRemoteDataSourceImpl(gh<_i463.NetworkService>()));
    gh.factory<_i565.PharmacyDataSource>(() => _i176.PharmacyDataSourceImp(
        networkService: gh<_i463.NetworkService>()));
    gh.factory<_i758.AIReportDataSource>(
        () => _i178.AIReportDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i1041.PatientDataSource>(
        () => _i148.PatientDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i888.HomeDataSource>(
        () => _i575.HomeDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i425.AIReportRepo>(
        () => _i779.AiReportRepoImp(gh<_i758.AIReportDataSource>()));
    gh.factory<_i158.AiReportCubit>(
        () => _i158.AiReportCubit(gh<_i425.AIReportRepo>()));
    gh.factory<_i184.DoctorAuthDataSource>(
        () => _i964.DoctorAuthDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i377.SearchRemoteDataSource>(
        () => _i873.SearchDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i377.FacilityAuthDataSource>(
        () => _i120.FacilityAuthDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i576.AuthDataSource>(
        () => _i124.AuthDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i234.HomeRepo>(
        () => _i454.HomeRepoImp(gh<_i888.HomeDataSource>()));
    gh.factory<_i745.UsersCubit>(
        () => _i745.UsersCubit(gh<_i434.UserUseCase>()));
    gh.factory<_i829.FacilityAuthRepo>(
        () => _i92.FacilityRepoImp(gh<_i377.FacilityAuthDataSource>()));
    gh.factory<_i382.MedicationDataSource>(
        () => _i423.MedicationDataSourceImp(gh<_i463.NetworkService>()));
    gh.factory<_i139.CompleteDataSource>(() => _i580.CompleteDataSourceImp(
        networkService: gh<_i463.NetworkService>()));
    gh.factory<_i128.PatientRepo>(
        () => _i856.PatientRepoImp(gh<_i1041.PatientDataSource>()));
    gh.factory<_i966.MedicationRepo>(
        () => _i689.MedicationRepoImp(gh<_i382.MedicationDataSource>()));
    gh.factory<_i114.ClinicRepo>(
        () => _i334.ClinicRepoImp(gh<_i808.ClinicDataSource>()));
    gh.factory<_i530.CompletePatientRepo>(() => _i809.CompletePatientRepoImp(
        completeDataSource: gh<_i139.CompleteDataSource>()));
    gh.factory<_i499.PharmacyRepo>(() => _i596.PharmacyRepoImp(
        pharmacyDataSource: gh<_i565.PharmacyDataSource>()));
    gh.factory<_i269.SearchRepo>(() => _i216.SearchRepoImp(
          gh<_i377.SearchRemoteDataSource>(),
          gh<_i181.SearchLocalDataSource>(),
        ));
    gh.factory<_i621.FacilityAuthCubit>(
        () => _i621.FacilityAuthCubit(gh<_i829.FacilityAuthRepo>()));
    gh.factory<_i294.CompleteCubit>(
        () => _i294.CompleteCubit(gh<_i530.CompletePatientRepo>()));
    gh.factory<_i551.DoctorAuthRepo>(
        () => _i1023.DoctorAuthRepoImp(gh<_i184.DoctorAuthDataSource>()));
    gh.factory<_i243.ClinicCubit>(
        () => _i243.ClinicCubit(gh<_i114.ClinicRepo>()));
    gh.factory<_i851.ProfileRepo>(
        () => _i371.ProfileRepoImpl(gh<_i183.ProfileRemoteDataSource>()));
    gh.factory<_i481.MedicationCubit>(
        () => _i481.MedicationCubit(gh<_i966.MedicationRepo>()));
    gh.factory<_i246.AuthRepo>(
        () => _i49.AuthRepoImp(gh<_i576.AuthDataSource>()));
    gh.factory<_i930.PatientCubit>(() => _i930.PatientCubit(
          patientRepo: gh<_i128.PatientRepo>(),
          usersCubit: gh<_i745.UsersCubit>(),
        ));
    gh.factory<_i301.AuthCubit>(() => _i301.AuthCubit(
          repo: gh<_i246.AuthRepo>(),
          usersCubit: gh<_i745.UsersCubit>(),
        ));
    gh.factory<_i840.PharmacyCubit>(
        () => _i840.PharmacyCubit(gh<_i499.PharmacyRepo>()));
    gh.factory<_i236.DoctorAuthCubit>(() => _i236.DoctorAuthCubit(
          doctorAuthRepo: gh<_i551.DoctorAuthRepo>(),
          usersCubit: gh<_i745.UsersCubit>(),
        ));
    gh.factory<_i1023.SearchCubit>(
        () => _i1023.SearchCubit(gh<_i269.SearchRepo>()));
    gh.factory<_i779.ProfileCubit>(
        () => _i779.ProfileCubit(gh<_i851.ProfileRepo>()));
    return this;
  }
}
