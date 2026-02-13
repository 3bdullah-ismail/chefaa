// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../presentation/doctor/auth/data/data_sources/data_source.dart'
    as _i184;
import '../../presentation/doctor/auth/data/data_sources/data_source_imp.dart'
    as _i964;
import '../../presentation/doctor/auth/data/repositories/repo.dart' as _i551;
import '../../presentation/doctor/auth/data/repositories/repo_imp.dart'
    as _i1023;
import '../../presentation/doctor/auth/presentation/manager/doctor_auth_cubit.dart'
    as _i236;
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
import '../../presentation/pharmacy/data/data_sources/pharmacy_data_source.dart'
    as _i1063;
import '../../presentation/pharmacy/data/data_sources/pharmacy_data_source_imp.dart'
    as _i805;
import '../../presentation/pharmacy/data/repositories/pharmacy_repo.dart'
    as _i342;
import '../../presentation/pharmacy/data/repositories/pharmacy_repo_imp.dart'
    as _i567;
import '../../presentation/pharmacy/presentation/manager/pharmacy_cubit.dart'
    as _i64;
import '../services/network_service.dart' as _i463;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i463.NetworkService>(() => _i463.NetworkService());
    gh.factory<_i1041.PatientDataSource>(
      () => _i148.PatientDataSourceImp(gh<_i463.NetworkService>()),
    );
    gh.factory<_i1063.PharmacyDataSource>(
      () => _i805.PharmacyDataSourceImp(
        networkService: gh<_i463.NetworkService>(),
      ),
    );
    gh.factory<_i139.CompleteDataSource>(
      () => _i580.CompleteDataSourceImp(
        networkService: gh<_i463.NetworkService>(),
      ),
    );
    gh.factory<_i184.DoctorAuthDataSource>(
      () => _i964.DoctorAuthDataSourceImp(gh<_i463.NetworkService>()),
    );
    gh.factory<_i342.PharmacyRepo>(
      () => _i567.PharmacyRepoImp(
        pharmacyDataSource: gh<_i1063.PharmacyDataSource>(),
      ),
    );
    gh.factory<_i64.PharmacyCubit>(
      () => _i64.PharmacyCubit(gh<_i342.PharmacyRepo>()),
    );
    gh.factory<_i551.DoctorAuthRepo>(
      () => _i1023.DoctorAuthRepoImp(gh<_i184.DoctorAuthDataSource>()),
    );
    gh.factory<_i530.CompletePatientRepo>(
      () => _i809.CompletePatientRepoImp(
        completeDataSource: gh<_i139.CompleteDataSource>(),
      ),
    );
    gh.factory<_i128.PatientRepo>(
      () => _i856.PatientRepoImp(gh<_i1041.PatientDataSource>()),
    );
    gh.factory<_i930.PatientCubit>(
      () => _i930.PatientCubit(gh<_i128.PatientRepo>()),
    );
    gh.factory<_i236.DoctorAuthCubit>(
      () => _i236.DoctorAuthCubit(gh<_i551.DoctorAuthRepo>()),
    );
    gh.factory<_i294.CompleteCubit>(
      () => _i294.CompleteCubit(gh<_i530.CompletePatientRepo>()),
    );
    return this;
  }
}
