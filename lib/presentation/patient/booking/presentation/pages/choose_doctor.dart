import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/choose_doctor_cubit.dart';
import 'choose_doctor_view.dart';

class ChooseDoctor extends StatelessWidget {
  const ChooseDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChooseDoctorCubit(),
      child: const ChooseDoctorView(),
    );
  }
}

