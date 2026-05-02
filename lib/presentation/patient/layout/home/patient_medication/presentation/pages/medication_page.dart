import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/manager/medication_cubit.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/manager/medication_state.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/add_medication.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/edit_bottom_sheet.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/medication_card.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/over_view_card.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/suggest_card.dart';
import 'package:chefaa/presentation/patient/layout/home/presentation/widgets/ai_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/bottom_sheet.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  @override
  void initState() {
    super.initState();
    context.read<MedicationCubit>().getMedicationList();
  }

  void _openAddSheet(BuildContext context) {
    context.read<MedicationCubit>().clearControllers();
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.lightGray,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<MedicationCubit>(),
        child: const FractionallySizedBox(
          heightFactor: 0.92,
          child: BottomSheetCard(
            title: "Add Medication",
            content: "Enter your medication details for tracking and reminders.",
          ),
        ),
      ),
    ).then((_) {
      context.read<MedicationCubit>().getMedicationList();
    });
  }

  void _openEditSheet(BuildContext context, String medicationId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.lightGray,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<MedicationCubit>(),
        child: FractionallySizedBox(
          heightFactor: 0.92,
          child: EditBottomSheet(
            medicationId: medicationId,
            title: "Edit Medication",
            content: "Update your medication details.",
          ),
        ),
      ),
    ).then((_) {
      context.read<MedicationCubit>().getMedicationList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: InsideAppBar(
          title: "My Medications ",
          subtitle: "Track and manage your medication schedule",
          height: 130,
        ),
      ),
      body: BlocBuilder<MedicationCubit, MedicationState>(
        buildWhen: (previous, current) =>
        current is MedicationListLoadingState ||
            current is MedicationListSuccessState ||
            current is MedicationListErrorState,
        builder: (context, state) {
          if (state is MedicationListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          }

          if (state is MedicationListErrorState) {
            return Center(
              child: Text(
                state.errorMessage,
                style: getMediumStyle(color: ColorManager.error),
              ),
            );
          }

          if (state is MedicationListSuccessState) {
            final medicationList = state.medications;
            final medications = state.medications.medications ?? [];

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p32,
                  left: AppPadding.p20,
                  right: AppPadding.p20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OverViewCard(
                          label: "Avg.Adherence",
                          title: "${medicationList.stats?.avgAdherence ?? 0}",
                        ),
                        OverViewCard(
                          label: "Active Medications",
                          title:
                          "${medicationList.stats?.activeMedications ?? 0}",
                          isActive: true,
                        ),
                      ],
                    ),
                    const SuggestCard(),
                    5.verticalSpace,
                    Row(
                      children: [
                        Text(
                          "Medications",
                          style: getMediumStyle(
                            color: ColorManager.black,
                          ).copyWith(fontSize: 20),
                        ),
                        const Spacer(),
                        AddMedication(
                          onTap: () => _openAddSheet(context),
                        ),
                      ],
                    ),
                    ListView.separated(
                      itemBuilder: (_, index) => MedicationCard(
                        medications: medications,
                        index: index,
                        onPressed: () {
                          final id = medications[index].id ?? '';
                          _openEditSheet(context, id);
                        },
                      ),
                      separatorBuilder: (_, _) => const SizedBox(height: 20),
                      itemCount: medications.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                    const AiSuggestion(),
                    5.verticalSpace,
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}