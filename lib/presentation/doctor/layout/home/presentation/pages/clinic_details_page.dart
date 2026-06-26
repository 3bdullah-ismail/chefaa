import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/config/get_config.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../core/widget/inside_app_bar.dart';
import '../../data/models/clinic.dart';
import '../../data/models/clinics.dart';
import '../manager/clinic_cubit.dart';
import '../manager/clinic_state.dart';
import '../widgets/clinic_card_details.dart';

class ClinicDetailsPage extends StatefulWidget {
  const ClinicDetailsPage({super.key});

  @override
  State<ClinicDetailsPage> createState() => _ClinicDetailsPageState();
}

class _ClinicDetailsPageState extends State<ClinicDetailsPage> {
  Clinic? clinic;


  @override
  Widget build(BuildContext context) {
    var clinics = ModalRoute.of(context)!.settings.arguments as Clinics;

    return BlocProvider(
        create: (_) =>
        getIt<ClinicCubit>()
          ..getClinicByID(clinicID: clinics.id ?? ""),

      child: BlocListener<ClinicCubit, ClinicState>(
        listener: (context, state) {
          if (state is ClinicDeleteSuccessState) {
            Navigator.pop(context);
          }
        },

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
                clinic = state.clinic;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20,
                      vertical: AppPadding.p32,
                    ),
                    child: Column(
                      children: [ClinicCardDetails(clinic: state.clinic)],
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
