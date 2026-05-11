import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/manager/medication_cubit.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/manager/medication_state.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/dose_card.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/medication_calender.dart';
import 'package:chefaa/presentation/patient/layout/home/presentation/widgets/ai_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/styles_manager.dart';
import '../../../../../../../core/resources/values_manager.dart';
import '../../../../../../../core/widget/custom_dropdown_btn.dart';
import '../../../../../../../core/widget/custom_text_field.dart';
import '../../../../../profile/presentation/widgets/item_container.dart';

class BottomSheetCard extends StatefulWidget {
  final String title;
  final String content;

  const BottomSheetCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<BottomSheetCard> createState() => _BottomSheetCardState();
}

class _BottomSheetCardState extends State<BottomSheetCard> {
  List<TimeOfDay?> selectedTimes = [];

  void generateDoses(String value) {
    switch (value) {
      case "Once a day (1)":
        selectedTimes = [null];
        break;
      case "Every 12 hours":
        selectedTimes = [null, null];
        break;
      case "Every 8 hours":
        selectedTimes = [null, null, null];
        break;
      case "As needed":
        selectedTimes = [];
        break;
      default:
        selectedTimes = [];
    }
  }

  void deleteDose(int index) {
    if (index < selectedTimes.length) {
      setState(() => selectedTimes.removeAt(index));
    }
  }

  Future<void> pickTime(int index) async {
    if (index >= selectedTimes.length) return;
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTimes[index] ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => selectedTimes[index] = picked);
  }

  String _formatTime(TimeOfDay t) {
    final period = t.hour < 12 ? 'AM' : 'PM';
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  void _syncScheduleToCubit(MedicationCubit cubit) {
    cubit.scheduleController.text = selectedTimes
        .whereType<TimeOfDay>()
        .map(_formatTime)
        .join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicationCubit, MedicationState>(
      listener: (context, state) {
        if (state is MedicationAdditionSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Medication added successfully!")),
          );
          Navigator.pop(context);
        }
        if (state is MedicationAdditionErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        final cubit = MedicationCubit.get(context);
        final isLoading = state is MedicationAdditionLoadingState;

        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .92,
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20,
                      vertical: AppPadding.p16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 8, bottom: 18),
                            height: 2.5,
                            width: 150,
                            decoration: BoxDecoration(
                              color: ColorManager.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Text(
                          "Add Medication",
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 24,
                          ),
                        ),
                        6.verticalSpace,
                        Text(
                          "Enter your medication details for tracking and reminders.",
                          style: getSemiBoldStyle(
                            color: ColorManager.gray,
                            fontSize: 14,
                          ),
                        ),
                        24.verticalSpace,

                        ItemContainer(
                          isMedication: true,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Medication Name",
                                  style: getMediumStyle(
                                    color: ColorManager.black,
                                    fontSize: 16,
                                  ),
                                ),
                                8.verticalSpace,
                                CustomTextField(
                                  controller: cubit.nameController,
                                  text: "e.g. Metformin",
                                ),
                                16.verticalSpace,
                                Text(
                                  "Dosage",
                                  style: getMediumStyle(
                                    color: ColorManager.black,
                                    fontSize: 16,
                                  ),
                                ),
                                8.verticalSpace,
                                CustomTextField(
                                  controller: cubit.dosageController,
                                  text: "e.g. 500mg",
                                ),
                                16.verticalSpace,
                                Text(
                                  "Form",
                                  style: getMediumStyle(
                                    color: ColorManager.black,
                                    fontSize: 16,
                                  ),
                                ),
                                8.verticalSpace,
                                CustomDropDownBtn(
                                  items: AppConstants.formItems,
                                  hintText: "Select form",
                                  value: cubit.formController.text.isEmpty
                                      ? null
                                      : cubit.formController.text,
                                  onChanged: (value) => setState(
                                    () => cubit.formController.text = value!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        20.verticalSpace,

                        ItemContainer(
                          isMedication: true,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Schedule",
                                  style: getMediumStyle(
                                    color: ColorManager.black,
                                    fontSize: 18,
                                  ),
                                ),
                                20.verticalSpace,
                                Text(
                                  "Times per day",
                                  style: getMediumStyle(
                                    color: ColorManager.black,
                                    fontSize: 16,
                                  ),
                                ),
                                8.verticalSpace,
                                CustomDropDownBtn(
                                  items: AppConstants.timesPerDayItems,
                                  hintText: "Select frequency",
                                  value:
                                      cubit.timesPerDayController.text.isEmpty
                                      ? null
                                      : cubit.timesPerDayController.text,
                                  onChanged: (value) {
                                    if (value == null) return;
                                    setState(() {
                                      cubit.setTimesPerDay(value);
                                      generateDoses(value);
                                    });
                                  },
                                ),
                                18.verticalSpace,
                                Text(
                                  "Dose Times",
                                  style: getMediumStyle(
                                    color: ColorManager.black,
                                    fontSize: 16,
                                  ),
                                ),
                                12.verticalSpace,
                                DoseCard(
                                  selectedTimes: selectedTimes,
                                  onPickTime: pickTime,
                                  deleteDose: deleteDose,
                                ),
                                20.verticalSpace,

                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Start Date",
                                            style: getMediumStyle(
                                              color: ColorManager.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                          12.verticalSpace,
                                          MedicationCalender(
                                            isMedication: true,
                                            hintText: "Select start date",
                                            controller:
                                                cubit.startDateController,
                                            onDateSelected: (date) => setState(
                                              () {
                                                cubit.startDateController.text =
                                                    DateFormat(
                                                      'yyyy-MM-dd',
                                                    ).format(date);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    12.horizontalSpace,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "End Date",
                                            style: getMediumStyle(
                                              color: ColorManager.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                          12.verticalSpace,
                                          MedicationCalender(
                                            isMedication: true,
                                            hintText: "Select end date",
                                            controller: cubit.endDateController,
                                            onDateSelected: (date) =>
                                                setState(() {
                                                  cubit.endDateController.text =
                                                      DateFormat(
                                                        'yyyy-MM-dd',
                                                      ).format(date);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                20.verticalSpace,

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Continuous medication",
                                      style: getMediumStyle(
                                        color: ColorManager.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => setState(
                                        () => cubit.isActive = !cubit.isActive,
                                      ),
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        width: 55,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: cubit.isActive
                                              ? ColorManager.primary
                                              : ColorManager.input,
                                        ),
                                        child: AnimatedAlign(
                                          duration: const Duration(
                                            milliseconds: 200,
                                          ),
                                          alignment: cubit.isActive
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            margin: const EdgeInsets.all(2),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        20.verticalSpace,
                        const AiSuggestion(),
                        10.verticalSpace,
                        CustomBtn(
                          text: "Add Medication",
                          onPressed: () {
                            _syncScheduleToCubit(cubit);
                            cubit.addMedication();
                          },
                        ),
                        20.verticalSpace,
                      ],
                    ),
                  ),
                ),

                if (isLoading)
                  Container(
                    color: Colors.white.withAlpha(180),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
