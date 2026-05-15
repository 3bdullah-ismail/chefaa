import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/data/models/Medications.dart';
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
import '../../../../../../../core/resources/constants_manager.dart';
import '../../../../../../../core/resources/styles_manager.dart';
import '../../../../../../../core/resources/values_manager.dart';
import '../../../../../../../core/widget/custom_dropdown_btn.dart';
import '../../../../../../../core/widget/custom_text_field.dart';
import '../../../../../../../core/widget/loading.dart';
import '../../../../../profile/presentation/widgets/item_container.dart';
import 'alert_dialog.dart';
import 'outline_button.dart';

class EditBottomSheet extends StatefulWidget {
  final String title;
  final String content;
  final String medicationId;

  const EditBottomSheet({
    super.key,
    required this.title,
    required this.content,
    required this.medicationId,
  });

  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  List<TimeOfDay?> selectedTimes = [];
  String? selectedForm;
  String? selectedTimesPerDay;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _populateForEdit());
  }

  Future<void> _populateForEdit() async {
    final cubit = MedicationCubit.get(context);

    if (cubit.state is! MedicationListSuccessState) {
      await cubit.getMedicationList();
    }

    final state = cubit.state;
    if (state is! MedicationListSuccessState) return;

    final meds = state.medications.medications ?? [];
    Medications? med;
    try {
      med = meds.firstWhere((m) => m.id == widget.medicationId);
    } catch (_) {
      return;
    }

    final formLabel = AppConstants.formToDropdownLabel(med.form);
    final timesLabel = AppConstants.timesPerDayToLabel(med.timesPerDay);
    final schedule = med.schedule ?? [];

    setState(() {
      cubit.nameController.text = med?.name ?? '';
      cubit.dosageController.text = (med?.dosage ?? '')
          .replaceAll(RegExp(r'\s*mg\s*$', caseSensitive: false), '')
          .trim();

      selectedForm = formLabel;
      cubit.formController.text = formLabel;

      selectedTimesPerDay = timesLabel;
      cubit.setTimesPerDay(timesLabel);

      cubit.scheduleController.text = schedule.join(', ');
      cubit.startDateController.text = med?.startDate ?? '';
      cubit.endDateController.text = med?.endDate ?? '';
      cubit.isActive = med?.isActive ?? false;

      selectedTimes = schedule.map<TimeOfDay?>((s) {
        try {
          return TimeOfDay.fromDateTime(DateFormat('hh:mm a').parseLoose(s));
        } catch (_) {
          return null;
        }
      }).toList();

      if (selectedTimes.isEmpty) {
        _generateDosesFromTimesPerDay(med?.timesPerDay ?? 1);
      }
    });
  }

  void _generateDosesFromTimesPerDay(num timesPerDay) {
    switch (timesPerDay.toInt()) {
      case 1:
        selectedTimes = [null];
        break;
      case 2:
        selectedTimes = [null, null];
        break;
      case 3:
        selectedTimes = [null, null, null];
        break;
      default:
        selectedTimes = [];
    }
  }

  void _generateDosesFromLabel(String value) {
    setState(() {
      switch (value) {
        case 'Once a day (1)':
          selectedTimes = [null];
          break;
        case 'Every 12 hours':
          selectedTimes = [null, null];
          break;
        case 'Every 8 hours':
          selectedTimes = [null, null, null];
          break;
        default:
          selectedTimes = [];
      }
    });
  }

  void deleteDose(int index) {
    if (index < selectedTimes.length) {
      setState(() => selectedTimes.removeAt(index));
    }
  }

  Future<void> pickTime(int index) async {
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
    final cubit = MedicationCubit.get(context);

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.92,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p16,
            ),
            child: BlocListener<MedicationCubit, MedicationState>(
              listener: (context, state) {
                if (state is MedicationUpdateLoadingState ||
                    state is MedicationDeleteLoadingState) {
                  Loading.show(context);
                } else if (state is MedicationUpdateSuccessState) {
                  Loading.hide(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Medication updated successfully'),
                    ),
                  );
                  Navigator.pop(context);
                } else if (state is MedicationDeleteSuccessState) {
                  Loading.hide(context);
                  Navigator.pop(context);
                } else if (state is MedicationUpdateErrorState) {
                  Loading.hide(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                } else if (state is MedicationDeleteErrorState) {
                  Loading.hide(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                }
              },
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
                    widget.title,
                    style: getBoldStyle(
                      fontSize: 24,
                      color: ColorManager.black,
                    ),
                  ),
                  6.verticalSpace,
                  Text(
                    widget.content,
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
                            text: "e.g. 500",
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
                            hintText: cubit.formController.text.isEmpty
                                ? "Select form"
                                : cubit.formController.text,
                            value: selectedForm,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                selectedForm = value;
                                cubit.formController.text = value;
                              });
                            },
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
                            hintText: cubit.timesPerDayController.text.isEmpty
                                ? "Select times per day"
                                : cubit.timesPerDayController.text,
                            value: selectedTimesPerDay,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                selectedTimesPerDay = value;
                                cubit.setTimesPerDay(value);
                                _generateDosesFromLabel(value);
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      controller: cubit.startDateController,
                                      onDateSelected: (date) => setState(() {
                                        cubit.startDateController.text =
                                            DateFormat(
                                              'yyyy-MM-dd',
                                            ).format(date);
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      onDateSelected: (date) => setState(() {
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  duration: const Duration(milliseconds: 200),
                                  width: 55,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: cubit.isActive
                                        ? ColorManager.primary
                                        : ColorManager.input,
                                  ),
                                  child: AnimatedAlign(
                                    duration: const Duration(milliseconds: 200),
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
                    text: "Update Medication",
                    onPressed: () {
                      _syncScheduleToCubit(cubit);
                      cubit.updateMedication(medicationId: widget.medicationId);
                    },
                  ),
                  12.verticalSpace,

                  Center(
                    child: OutlineButton(
                      title: "Delete Medication",
                      isEditSheet: true,
                      color: ColorManager.error,
                      onPressed: () {
                        DeleteMedicationDialog.show(
                          context: context,
                          medicationId: widget.medicationId,
                          cubit: cubit,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
