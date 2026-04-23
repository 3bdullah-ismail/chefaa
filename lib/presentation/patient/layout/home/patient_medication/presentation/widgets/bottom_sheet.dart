import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/dose_card.dart';
import 'package:chefaa/presentation/patient/layout/home/presentation/widgets/ai_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/styles_manager.dart';
import '../../../../../../../core/resources/values_manager.dart';
import '../../../../../../../core/widget/custom_calender.dart';
import '../../../../../../../core/widget/custom_dropdown_btn.dart';
import '../../../../../../../core/widget/custom_text_field.dart';
import '../../../../../profile/presentation/widgets/item_container.dart';

class BottomSheetCard extends StatefulWidget {
  final String title;
  final String content;
  final bool edition;

  const BottomSheetCard({
    super.key,
    this.edition = false,
    required this.title,
    required this.content,
  });

  @override
  State<BottomSheetCard> createState() => _BottomSheetCardState();
}

class _BottomSheetCardState extends State<BottomSheetCard> {
  String? formType;
  String? timesPerDay;
  DateTime? startDate;
  DateTime? endDate;
  bool isOn = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  List<TimeOfDay?> selectedTimes = [null, null];

  void addDose() {
    setState(() {
      selectedTimes.add(null);
    });
  }

  void deleteDose(int index) {
    if (selectedTimes.length > 1) {
      setState(() {
        selectedTimes.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: getBoldStyle(
                    color: ColorManager.black,
                  ).copyWith(fontSize: 24),
                ),
                6.verticalSpace,
                Text(
                  widget.content,
                  style: getSemiBoldStyle(
                    color: ColorManager.gray,
                  ).copyWith(fontSize: 14),
                ),
                24.verticalSpace,
              ],
            ),
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
                      controller: nameController,
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
                      controller: dosageController,
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
                      items: const [
                        "Tablet",
                        "Capsule",
                        "Syrup",
                        "Injection",
                        "Cream",
                        "Drops",
                        "Inhaler",
                        "Suppository",
                      ],
                      hintText: "Select form",
                      value: formType,
                      onChanged: (value) {
                        setState(() => formType = value);
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
                      items: const [
                        "Once a day (1)",
                        "Twice a day (2)",
                        "3 times a day (3)",
                        "4 times a day (4)",
                        "Every 4 hours",
                        "Every 6 hours",
                        "Every 8 hours",
                        "Every 12 hours",
                        "As needed",
                      ],
                      hintText: "Select frequency",
                      value: timesPerDay,
                      onChanged: (value) {
                        setState(() => timesPerDay = value);
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
                      addDose: addDose,
                      deleteDose: deleteDose,
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
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
                            CustomCalendarField(
                              isMedication: true,
                              hintText: "Select start date",
                              controller: startDateController,
                              onDateSelected: (date) {
                                setState(() {
                                  startDate = date;
                                });
                              },
                            ),
                          ],
                        ),

                        Column(
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
                            CustomCalendarField(
                              isMedication: true,
                              hintText: "Select end date",
                              controller: endDateController,
                              onDateSelected: (date) {
                                setState(() {
                                  endDate = date;
                                });
                              },
                            ),
                          ],
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
                          onTap: () {
                            setState(() {
                              isOn = !isOn;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 55,
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isOn
                                  ? ColorManager.primary
                                  : ColorManager.input,
                            ),
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 200),
                              alignment: isOn
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
            widget.edition
                ? Column(
              children: [
                CustomBtn(text: "Save Medication", onPressed: () {}),
                10.verticalSpace,
                CustomBtn(text: "Delete", onPressed: () {}),
              ],
            )
                : const AiSuggestion(),
          ],
        ),
      ),
    );
  }

  Future<void> pickTime(int index) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTimes[index] ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTimes[index] = picked;
      });
    }
  }
}
