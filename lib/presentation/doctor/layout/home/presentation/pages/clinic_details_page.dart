import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/config/get_config.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../core/widget/inside_app_bar.dart';
import '../../data/models/Clinics.dart';
import '../manager/clinic_cubit.dart';
import '../manager/clinic_state.dart';
import '../widgets/clinic_card_details.dart';

class ClinicDetailsPage extends StatelessWidget {
  const ClinicDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clinic = ModalRoute.of(context)!.settings.arguments as Clinics;

    return BlocProvider(
      create: (_) => getIt<ClinicCubit>()..getClinicByID(clinicID: clinic.id ?? ""),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: InsideAppBar(title: "Clinic Details"),
        ),
        body: BlocBuilder<ClinicCubit, ClinicState>(
          builder: (context, state) {
            if (state is ClinicLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ClinicErrorState) {
              return Center(child: Text(state.message));
            }
            if (state is ClinicSuccessState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p20,
                    vertical: AppPadding.p32,
                  ),
                  child: Column(
                    children: [
                      ClinicCardDetails(clinic: state.clinic),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}