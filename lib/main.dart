import 'package:chefaa/shared/file_handler/presentation/manager/file_handler_cubit.dart';
import 'package:chefaa/features/auth/presentation/manager/auth_cubit.dart';
import 'package:chefaa/features/patient/ai_lab/presentation/manager/ai_report_cubit.dart';
import 'package:chefaa/features/patient/booking/presentation/manager/booking_cubit.dart';
import 'package:chefaa/features/patient/medication/presentation/manager/medication_cubit.dart';
import 'package:chefaa/features/patient/home/presentation/manager/users_cubit.dart';
import 'package:chefaa/features/patient/search/presentation/manager/search_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'chefaa.dart';
import 'core/config/get_config.dart';
import 'core/services/app_bloc_observer.dart';
import 'core/services/hive_service.dart';
import 'core/services/notification_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await HiveService.openBox(HiveBoxes.reportsBox);
  await EasyLocalization.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    debugPrint("Firebase options initialization failed, falling back to default initialization: $e");
    try {
      await Firebase.initializeApp();
    } catch (val) {
      debugPrint("Firebase default initialization failed: $val");
    }
  }
  await NotificationService().initialize();
  configureDependencies();
  Bloc.observer = AppBlocObserver();
  await GoogleSignIn.instance.initialize(
    serverClientId:
        "50620876414-hfv5genejr18gdoi522k6gb9t5ajt43o.apps.googleusercontent.com",
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => FileHandlerCubit()),
          BlocProvider(create: (_) => getIt<UsersCubit>()..loadUserFromPrefs()),
          BlocProvider(create: (_) => getIt<AuthCubit>()),
          BlocProvider(create: (_) => getIt<SearchCubit>()),
          BlocProvider(create: (_) => getIt<AiReportCubit>()),
          BlocProvider(
            create: (_) => getIt<MedicationCubit>()..getMedicationList(),
          ),
          BlocProvider(create: (_) => getIt<BookingCubit>()),
        ],
        child: const Chefaa(),
      ),
    ),
  );
}
