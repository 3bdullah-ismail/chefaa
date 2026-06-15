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
import 'package:chefaa/presentation/patient/layout/home/data/data_sources/home_data_source.dart'
    as _i228;
import 'package:chefaa/presentation/patient/layout/home/data/data_sources/home_data_source_imp.dart'
    as _i909;
import 'package:chefaa/presentation/patient/layout/home/data/repositories/home_repo.dart'
    as _i271;
import 'package:chefaa/presentation/patient/layout/home/data/repositories/home_repo_imp.dart'
    as _i729;
import 'package:chefaa/presentation/patient/layout/home/data/users_domain/domain/user_usecase.dart'
    as _i102;
import 'package:chefaa/presentation/patient/layout/home/patient_medication/data/data_sources/medication_data_source.dart'
    as _i79;
import 'package:chefaa/presentation/patient/layout/home/patient_medication/data/data_sources/medication_data_source_imp.dart'
    as _i132;
import 'package:chefaa/presentation/patient/layout/home/patient_medication/data/repositories/medication_repo.dart'
    as _i340;
import 'package:chefaa/presentation/patient/layout/home/patient_medication/data/repositories/medication_repo_imp.dart'
    as _i297;
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/manager/medication_cubit.dart'
    as _i662;
import 'package:chefaa/presentation/patient/layout/home/presentation/manager/users_cubit.dart'
    as _i649;
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
    gh.factory<_i102.UserUseCase>(() => _i102.UserUseCase());
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
    gh.factory<_i564.AIReportDataSource>(
        () => _i1062.AIReportDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i597.PatientDataSource>(
        () => _i708.PatientDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i169.SearchRemoteDataSource>(
        () => _i623.SearchDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i228.HomeDataSource>(
        () => _i909.HomeDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i17.AIReportRepo>(
        () => _i88.AiReportRepoImp(gh<_i564.AIReportDataSource>()));
    gh.factory<_i366.AiReportCubit>(
        () => _i366.AiReportCubit(gh<_i17.AIReportRepo>()));
    gh.factory<_i598.DoctorProfileRemoteDataSource>(
        () => _i5.DoctorProfileRemoteDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i13.DoctorAuthDataSource>(
        () => _i875.DoctorAuthDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i339.AuthDataSource>(
        () => _i81.AuthDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i271.HomeRepo>(
        () => _i729.HomeRepoImp(gh<_i228.HomeDataSource>()));
    gh.factory<_i649.UsersCubit>(
        () => _i649.UsersCubit(gh<_i102.UserUseCase>()));
    gh.factory<_i60.FacilityAuthDataSource>(
        () => _i29.FacilityAuthDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i79.MedicationDataSource>(
        () => _i132.MedicationDataSourceImp(gh<_i492.NetworkService>()));
    gh.factory<_i1028.CompleteDataSource>(() => _i450.CompleteDataSourceImp(
        networkService: gh<_i492.NetworkService>()));
    gh.factory<_i212.PatientRepo>(
        () => _i473.PatientRepoImp(gh<_i597.PatientDataSource>()));
    gh.factory<_i340.MedicationRepo>(
        () => _i297.MedicationRepoImp(gh<_i79.MedicationDataSource>()));
    gh.factory<_i426.ClinicRepo>(
        () => _i210.ClinicRepoImp(gh<_i465.ClinicDataSource>()));
    gh.factory<_i695.CompletePatientRepo>(() => _i801.CompletePatientRepoImp(
        completeDataSource: gh<_i1028.CompleteDataSource>()));
    gh.factory<_i235.PharmacyRepo>(() => _i71.PharmacyRepoImp(
        pharmacyDataSource: gh<_i831.PharmacyDataSource>()));
    gh.factory<_i40.CompleteCubit>(
        () => _i40.CompleteCubit(gh<_i695.CompletePatientRepo>()));
    gh.factory<_i260.DoctorAuthRepo>(
        () => _i969.DoctorAuthRepoImp(gh<_i13.DoctorAuthDataSource>()));
    gh.factory<_i819.ClinicCubit>(
        () => _i819.ClinicCubit(gh<_i426.ClinicRepo>()));
    gh.factory<_i336.FacilityAuthRepo>(
        () => _i221.FacilityRepoImp(gh<_i60.FacilityAuthDataSource>()));
    gh.factory<_i229.ProfileRepo>(
        () => _i851.ProfileRepoImpl(gh<_i723.ProfileRemoteDataSource>()));
    gh.factory<_i470.FacilityAuthCubit>(
        () => _i470.FacilityAuthCubit(gh<_i336.FacilityAuthRepo>()));
    gh.factory<_i662.MedicationCubit>(
        () => _i662.MedicationCubit(gh<_i340.MedicationRepo>()));
    gh.factory<_i216.AuthRepo>(
        () => _i63.AuthRepoImp(gh<_i339.AuthDataSource>()));
    gh.factory<_i483.SearchRepo>(() => _i331.SearchRepoImp(
          gh<_i169.SearchRemoteDataSource>(),
          gh<_i233.SearchLocalDataSource>(),
        ));
    gh.factory<_i556.PatientCubit>(() => _i556.PatientCubit(
          patientRepo: gh<_i212.PatientRepo>(),
          usersCubit: gh<_i649.UsersCubit>(),
        ));
    gh.factory<_i952.SearchCubit>(
        () => _i952.SearchCubit(gh<_i483.SearchRepo>()));
    gh.factory<_i440.DoctorProfileRepo>(() => _i962.DoctorProfileRepoImpl(
          gh<_i598.DoctorProfileRemoteDataSource>(),
          gh<_i945.DoctorProfileLocalDataSource>(),
        ));
    gh.factory<_i23.AuthCubit>(() => _i23.AuthCubit(
          repo: gh<_i216.AuthRepo>(),
          usersCubit: gh<_i649.UsersCubit>(),
        ));
    gh.factory<_i779.PharmacyCubit>(
        () => _i779.PharmacyCubit(gh<_i235.PharmacyRepo>()));
    gh.factory<_i249.GetDoctorDataUseCase>(
        () => _i249.GetDoctorDataUseCase(gh<_i440.DoctorProfileRepo>()));
    gh.factory<_i722.UpdateDoctorDataUseCase>(
        () => _i722.UpdateDoctorDataUseCase(gh<_i440.DoctorProfileRepo>()));
    gh.factory<_i677.DoctorAuthCubit>(() => _i677.DoctorAuthCubit(
          doctorAuthRepo: gh<_i260.DoctorAuthRepo>(),
          usersCubit: gh<_i649.UsersCubit>(),
        ));
    gh.factory<_i248.DoctorProfileCubit>(() => _i248.DoctorProfileCubit(
          getDoctorDataUseCase: gh<_i249.GetDoctorDataUseCase>(),
          updateDoctorDataUseCase: gh<_i722.UpdateDoctorDataUseCase>(),
        ));
    gh.factory<_i105.ProfileCubit>(
        () => _i105.ProfileCubit(gh<_i229.ProfileRepo>()));
    return this;
  }
}
