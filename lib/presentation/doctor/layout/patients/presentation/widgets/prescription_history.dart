import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/manager/patients_cubit.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/manager/patients_state.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/widgets/prescription_history_bottom_sheet.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/widgets/prescription_mini_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/patients/Prescription.dart';

class PrescriptionHistory extends StatefulWidget {
  const PrescriptionHistory({super.key});

  @override
  State<PrescriptionHistory> createState() => _PrescriptionHistoryState();
}

class _PrescriptionHistoryState extends State<PrescriptionHistory> {
  @override
  void initState() {
    super.initState();

    final cubit = context.read<PatientsCubit>();
    final appointment = cubit.selectedAppointment;

    if (appointment?.id != null) {
      cubit.getPreviousPrescriptions(appointmentId: appointment.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientsCubit, PatientsState>(
      buildWhen: (prev, curr) =>
      curr is PrescriptionPreviousLoadingState ||
          curr is PrescriptionPreviousSuccessState ||
          curr is PrescriptionPreviousErrorState,
      builder: (context, state) {
        if (state is PrescriptionPreviousLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PrescriptionPreviousErrorState) {
          return Center(child: Text(state.errorMessage));
        }

        final List<Prescription> prescriptions =
        state is PrescriptionPreviousSuccessState
            ? state.prescriptions
            : <Prescription>[];

        if (prescriptions.isEmpty) {
          return const Center(child: Text("No previous prescriptions"));
        }

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (_, _) => 15.verticalSpace,
          padding: const EdgeInsets.all(16),
          itemCount: prescriptions.length,
          itemBuilder: (context, index) {
            final item = prescriptions[index];
            final meds = item.data?.medicines ?? [];

            return PrescriptionMiniCard(
              prescriptionName: "Prescription ${index + 1}",
              date: item.data?.nextVisit ?? "",
              medsCount: meds.length,
              status: "completed",
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: ColorManager.lightGray,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) {
                    return BlocProvider.value(
                      value: context.read<PatientsCubit>(),
                      child: PrescriptionHistoryBottomSheet(
                        prescription: item,
                        medications: meds
                            .map((e) => {
                          "name": e.name ?? "",
                          "dosage": e.dosage ?? "",
                          "frequency": e.frequency ?? "",
                          "duration": e.duration ?? "",
                        })
                            .toList(),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}