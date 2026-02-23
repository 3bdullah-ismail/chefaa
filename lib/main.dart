import 'package:chefaa/core/manager/file_handler_cubit.dart';
import 'package:chefaa/presentation/auth/presentation/manager/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chefaa.dart';
import 'core/config/get_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FileHandlerCubit()),
        BlocProvider(create: (_) => getIt<AuthCubit>()),
      ],
      child: const Chefaa(),
    ),
  );
}
