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
import '../services/network_service.dart' as _i463;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i463.NetworkService>(() => _i463.NetworkService());
    gh.factory<_i184.DoctorAuthDataSource>(
      () => _i964.DoctorAuthDataSourceImp(gh<_i463.NetworkService>()),
    );
    gh.factory<_i551.DoctorAuthRepo>(
      () => _i1023.DoctorAuthRepoImp(gh<_i184.DoctorAuthDataSource>()),
    );
    gh.factory<_i236.DoctorAuthCubit>(
      () => _i236.DoctorAuthCubit(gh<_i551.DoctorAuthRepo>()),
    );
    return this;
  }
}
