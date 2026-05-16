import 'package:chefaa/core/manager/file_handler_cubit.dart';
import 'package:chefaa/presentation/auth/presentation/manager/auth_cubit.dart';
import 'package:chefaa/presentation/patient/ai_lab/presentation/manager/ai_report_cubit.dart';
import 'package:chefaa/presentation/patient/booking/presentation/manager/booking_provider.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/manager/medication_cubit.dart';
import 'package:chefaa/presentation/patient/layout/home/presentation/manager/users_cubit.dart';
import 'package:chefaa/presentation/patient/search/presentation/manager/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'chefaa.dart';
import 'core/config/get_config.dart';
import 'core/services/app_bloc_observer.dart';
import 'core/services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await HiveService.openBox(HiveBoxes.reportsBox);

  configureDependencies();
  Bloc.observer = AppBlocObserver();
  await GoogleSignIn.instance.initialize(
    serverClientId:
        "50620876414-hfv5genejr18gdoi522k6gb9t5ajt43o.apps.googleusercontent.com",
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FileHandlerCubit()),
        BlocProvider(create: (_) => getIt<UsersCubit>()..loadUserFromPrefs()),
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<SearchCubit>()),
        BlocProvider(create: (_) => getIt<AiReportCubit>()),
        BlocProvider(
          create: (_) => getIt<MedicationCubit>()..getMedicationList(),
        ),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: const Chefaa(),
    ),
  );
}
