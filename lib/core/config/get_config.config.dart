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
    gh.factory<_i139.CompleteDataSource>(
      () => _i580.CompleteDataSourceImp(
        networkService: gh<_i463.NetworkService>(),
      ),
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
    gh.factory<_i294.CompleteCubit>(
      () => _i294.CompleteCubit(gh<_i530.CompletePatientRepo>()),
    );
    return this;
  }
}
