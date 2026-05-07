// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../presentation/auth/data/data_sources/data_source.dart' as _i576;
import '../../presentation/auth/data/data_sources/data_source_imp.dart'
    as _i124;
import '../../presentation/auth/data/repositories/repo.dart' as _i246;
import '../../presentation/auth/data/repositories/repo_imp.dart' as _i49;
import '../../presentation/auth/presentation/manager/auth_cubit.dart' as _i301;
import '../../presentation/doctor/auth/data/data_sources/data_source.dart'
    as _i184;
import '../../presentation/doctor/auth/data/data_sources/data_source_imp.dart'
    as _i964;
import '../../presentation/doctor/auth/data/repositories/repo.dart' as _i551;
import '../../presentation/doctor/auth/data/repositories/repo_imp.dart'
    as _i1023;
import '../../presentation/doctor/auth/presentation/manager/doctor_auth_cubit.dart'
    as _i236;
import '../../presentation/Facility/auth/data/data_sources/data_source.dart'
    as _i377;
import '../../presentation/Facility/auth/data/data_sources/data_source_imp.dart'
    as _i120;
import '../../presentation/Facility/auth/data/repositories/repo.dart' as _i829;
import '../../presentation/Facility/auth/data/repositories/repo_imp.dart'
    as _i92;
import '../../presentation/Facility/auth/presentation/manager/facility_auth_cubit.dart'
    as _i621;
import '../../presentation/patient/ai_lab/data/datasources/ai_report_data_source.dart'
    as _i758;
import '../../presentation/patient/ai_lab/data/datasources/ai_report_data_source_imp.dart'
    as _i178;
import '../../presentation/patient/ai_lab/data/repositories/ai_report_repo.dart'
    as _i425;
import '../../presentation/patient/ai_lab/data/repositories/ai_report_repo_imp.dart'
    as _i779;
import '../../presentation/patient/ai_lab/presentation/manager/ai_report_cubit.dart'
    as _i158;
import '../../presentation/patient/auth/data/data_sources/patient_data_source.dart'
    as _i1041;
import '../../presentation/patient/auth/data/data_sources/patient_data_source_imp.dart'
    as _i148;
import '../../presentation/patient/auth/data/repositories/patient_repo.dart'
    as _i128;
import '../../presentation/patient/auth/data/repositories/patient_repo_imp.dart'
    as _i856;
import '../../presentation/patient/auth/presentation/manager/patient_cubit.dart'
    as _i930;
import '../../presentation/patient/booking/data/data_sources/remote_date_source/remote_data_source.dart'
    as _i372;
import '../../presentation/patient/booking/data/data_sources/remote_date_source/remote_data_source_impl.dart'
    as _i1020;
import '../../presentation/patient/complete_auth_data/data/data_sources/complete_data_source.dart'
    as _i139;
import '../../presentation/patient/complete_auth_data/data/data_sources/complete_data_source_imp.dart'
    as _i580;
import '../../presentation/patient/complete_auth_data/data/repositories/complete_patient_repo.dart'
    as _i530;
import '../../presentation/patient/complete_auth_data/data/repositories/complete_patient_repo_imp.dart'
    as _i809;
import '../../presentation/patient/complete_auth_data/presentation/manager/complete_cubit.dart'
    as _i294;
import '../../presentation/patient/layout/home/data/data_sources/home_data_source.dart'
    as _i888;
import '../../presentation/patient/layout/home/data/data_sources/home_data_source_imp.dart'
    as _i575;
import '../../presentation/patient/layout/home/data/repositories/home_repo.dart'
    as _i234;
import '../../presentation/patient/layout/home/data/repositories/home_repo_imp.dart'
    as _i454;
import '../../presentation/patient/layout/home/data/users_domain/domain/user_usecase.dart'
    as _i434;
import '../../presentation/patient/layout/home/patient_medication/data/data_sources/medication_data_source.dart'
    as _i382;
import '../../presentation/patient/layout/home/patient_medication/data/data_sources/medication_data_source_imp.dart'
    as _i423;
import '../../presentation/patient/layout/home/patient_medication/data/repositories/medication_repo.dart'
    as _i966;
import '../../presentation/patient/layout/home/patient_medication/data/repositories/medication_repo_imp.dart'
    as _i689;
import '../../presentation/patient/layout/home/patient_medication/presentation/manager/medication_cubit.dart'
    as _i481;
import '../../presentation/patient/layout/home/presentation/manager/users_cubit.dart'
    as _i745;
import '../../presentation/patient/profile/data/data_sources/remote_date_source/profile_remote_data_source.dart'
    as _i183;
import '../../presentation/patient/profile/data/data_sources/remote_date_source/profile_remote_data_source_imp.dart'
    as _i1047;
import '../../presentation/patient/profile/data/repositories/profile_repo.dart'
    as _i851;
import '../../presentation/patient/profile/data/repositories/profile_repo_imp.dart'
    as _i371;
import '../../presentation/patient/profile/presentation/manager/profile_cubit.dart'
    as _i779;
import '../../presentation/patient/search/data/datasources/local_data_source/search_local_data_source.dart'
    as _i181;
import '../../presentation/patient/search/data/datasources/local_data_source/search_local_data_source_imp.dart'
    as _i150;
import '../../presentation/patient/search/data/datasources/remote_date_source/search_remote_data_source.dart'
    as _i377;
import '../../presentation/patient/search/data/datasources/remote_date_source/search_remote_data_source_imp.dart'
    as _i873;
import '../../presentation/patient/search/data/repositories/search_repo.dart'
    as _i269;
import '../../presentation/patient/search/data/repositories/search_repo_imp.dart'
    as _i216;
import '../../presentation/patient/search/presentation/manager/search_cubit.dart'
    as _i1023;
import '../../presentation/pharmacy/auth/data/data_sources/pharmacy_data_source.dart'
    as _i565;
import '../../presentation/pharmacy/auth/data/data_sources/pharmacy_data_source_imp.dart'
    as _i176;
import '../../presentation/pharmacy/auth/data/repositories/pharmacy_repo.dart'
    as _i499;
import '../../presentation/pharmacy/auth/data/repositories/pharmacy_repo_imp.dart'
    as _i596;
import '../../presentation/pharmacy/auth/presentation/manager/pharmacy_cubit.dart'
    as _i840;
import '../services/network_service.dart' as _i463;

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
    gh.factory<_i434.UserUseCase>(() => _i434.UserUseCase());
    gh.lazySingleton<_i463.NetworkService>(() => _i463.NetworkService());
    gh.factory<_i181.SearchLocalDataSource>(
        () => _i150.SearchDoctorLocalDataSourceImp());
    gh.factory<_i372.BookingRemoteDataSource>(
        () => _i1020.BookingRemoteDataSourceImpl(gh<_i463.NetworkService>()));
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
    gh.factory<_i1023.SearchCubit>(
        () => _i1023.SearchCubit(gh<_i269.SearchRepo>()));
    gh.factory<_i779.ProfileCubit>(
        () => _i779.ProfileCubit(gh<_i851.ProfileRepo>()));
    gh.factory<_i236.DoctorAuthCubit>(
        () => _i236.DoctorAuthCubit(gh<_i551.DoctorAuthRepo>()));
    return this;
  }
}
