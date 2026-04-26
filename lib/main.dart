import 'package:chefaa/core/manager/file_handler_cubit.dart';
import 'package:chefaa/presentation/auth/presentation/manager/auth_cubit.dart';
import 'package:chefaa/presentation/patient/ai_lab/presentation/manager/ai_report_cubit.dart';
import 'package:chefaa/presentation/patient/layout/home/presentation/manager/users_cubit.dart';
import 'package:chefaa/presentation/patient/layout/search/presentation/manager/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'chefaa.dart';
import 'core/config/get_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox('reports');
  configureDependencies();
  // await GoogleSignIn.instance.initialize(
  //   serverClientId: "437264374965-9fs170cmqjtp67j0387nffs9dot3qdns.apps.googleusercontent.com");
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FileHandlerCubit()),
        BlocProvider(create: (_) => getIt<UsersCubit>()..loadUserFromPrefs()),
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<SearchCubit>()),
        BlocProvider(create: (_) => getIt<AiReportCubit>()),
      ],
      child: const Chefaa(),
    ),
  );
}