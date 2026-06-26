import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:chefaa/presentation/patient/medication/presentation/manager/medication_cubit.dart';
import 'package:chefaa/presentation/patient/medication/presentation/manager/medication_state.dart';
import 'package:chefaa/presentation/patient/medication/presentation/widgets/add_medication.dart';
import 'package:chefaa/presentation/patient/medication/presentation/widgets/medication_card.dart';
import 'package:chefaa/presentation/patient/medication/presentation/widgets/over_view_card.dart';
import 'package:chefaa/presentation/patient/medication/presentation/widgets/suggest_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/medications.dart';
import '../widgets/empty_medication_list_state.dart';
import '../widgets/medication_bottom_sheet.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  @override
  void initState() {
    super.initState();
    _loadMedications();
  }

  void _loadMedications() {
    final cubit = context.read<MedicationCubit>();
    cubit.getMedicationList(forceRefresh: true);
  }

  void _openAddSheet(BuildContext context) {
    final cubit = context.read<MedicationCubit>();
    cubit.clearControllers();

    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.lightGray,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const FractionallySizedBox(
          heightFactor: 0.92,
          child: MedicationBottomSheet(
            title: "Add Medication",
            content:
                "Enter your medication details for tracking and reminders.",
            isEdit: false,
          ),
        ),
      ),
    ).then((_) {
      if (!mounted) return;
      _loadMedications();
    });
  }

  void _openEditSheet(BuildContext context, Medications med) {
    final cubit = context.read<MedicationCubit>();

    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.lightGray,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: FractionallySizedBox(
          heightFactor: 0.92,
          child: MedicationBottomSheet(
            medication: med,
            title: "Edit Medication",
            content: "Update your medication details.",
            isEdit: true,
          ),
        ),
      ),
    ).then((_) {
      if (!mounted) return;
      _loadMedications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: InsideAppBar(
          title: "My Medications",
          subtitle: "Track and manage your medication schedule",
          height: 130,
        ),
      ),

      body: BlocConsumer<MedicationCubit, MedicationState>(
        listener: (context, state) {
          if (state is MedicationDeleteSuccessState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Medication deleted")));
            _loadMedications();
          }

          if (state is MedicationDeleteErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          if (state is MedicationListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MedicationListErrorState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 70,
                      color: Colors.red,
                    ),
                    20.verticalSpace,
                    Text(state.errorMessage, textAlign: TextAlign.center),
                    20.verticalSpace,
                    ElevatedButton(
                      onPressed: _loadMedications,
                      child: const Text("Try Again"),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is MedicationListSuccessState) {
            final medications = state.medications.medications ?? [];
            final bool isEmpty = medications.isEmpty;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p32,
                  left: AppPadding.p16,
                  right: AppPadding.p16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OverViewCard(
                            label: "Avg.Adherence",
                            title:
                                "${state.medications.stats?.avgAdherence ?? 0}",
                          ),
                          OverViewCard(
                            label: "Active Medications",
                            title:
                                "${state.medications.stats?.activeMedications ?? 0}",
                            isActive: true,
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      const SuggestCard(),
                      25.verticalSpace,

                      Row(
                        children: [
                          Text(
                            "Medications",
                            style: getMediumStyle(
                              color: ColorManager.black,
                              fontSize: 20.sp,
                            ),
                          ),
                          const Spacer(),
                          AddMedication(onTap: () => _openAddSheet(context)),
                        ],
                      ),
                      20.verticalSpace,
                    ],

                    if (isEmpty)
                      EmptyMedicationListState(
                        onAddPressed: () => _openAddSheet(context),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: medications.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 20),
                        itemBuilder: (_, index) => MedicationCard(
                          medications: medications,
                          index: index,
                          onPressed: () =>
                              _openEditSheet(context, medications[index]),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
