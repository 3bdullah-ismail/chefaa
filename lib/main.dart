import 'package:chefaa/core/manager/file_handler_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chefaa.dart';
import 'core/config/get_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => FileHandlerCubit())],
      child: const Chefaa(),
    ),
  );
}
