import 'package:chefaa/presentation/doctor/auth/presentation/manager/doctor_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chefaa.dart';
import 'core/config/get_config.dart';

void main() {
  configureDependencies();
  runApp(const Chefaa());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<DoctorAuthCubit>())],
      child: Chefaa(),
    ),
  );
}
