import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../doctor_data_sard.dart';
import '../../manager/choose_doctor_cubit.dart';
import '../../manager/choose_doctor_state.dart';

class ChooseDoctorResultsList extends StatelessWidget {
  const ChooseDoctorResultsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseDoctorCubit, ChooseDoctorState>(
      builder: (context, state) {
        if (state.filteredDoctors.isEmpty) {
          return const Center(child: Text('No doctors found'));
        }

        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: state.filteredDoctors.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return DoctorDataCard(doctorModel: state.filteredDoctors[index]);
          },
        );
      },
    );
  }
}

