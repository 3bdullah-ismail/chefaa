import 'package:chefaa/core/widget/inspector_bottom_sheet_container.dart';
import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/basic_info_section.dart';
import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/schedule_section.dart';
import 'package:chefaa/presentation/doctor/layout/home/presentation/widgets/working_days_section.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../../../core/widget/custom_btn.dart';
import '../../../../../patient/layout/home/presentation/widgets/ai_suggestion.dart';

class ClinicBottomSheet extends StatefulWidget {
  final String title;
  final String content;
  final bool isEdit;

  const ClinicBottomSheet({
    super.key,
    required this.title,
    this.isEdit = false,
    required this.content,
  });

  @override
  State<ClinicBottomSheet> createState() => _ClinicBottomSheetState();
}

class _ClinicBottomSheetState extends State<ClinicBottomSheet> {
  String? activeDay;

  final List<String> weekDays = const [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  final Map<String, bool> selectedDays = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
    "Sunday": false,
  };

  final Map<String, TimeOfDay?> openTimes = {};
  final Map<String, TimeOfDay?> closeTimes = {};

  final TextEditingController clinicNameController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController consultationPriceController =
      TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController latitudeController = TextEditingController();

  final TextEditingController longitudeController = TextEditingController();

  final TextEditingController licenseController = TextEditingController();

  final TextEditingController slotDurationController = TextEditingController();

  final TextEditingController maxPatientsController = TextEditingController();

  final TextEditingController patientPerSlotController =
      TextEditingController();

  Future<void> pickTime({
    required BuildContext context,
    required String day,
    required bool isOpen,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        if (isOpen) {
          openTimes[day] = picked;
        } else {
          closeTimes[day] = picked;
        }
      });
    }
  }

  void onDayTap(String day) {
    setState(() {
      selectedDays[day] = !(selectedDays[day] ?? false);

      if (selectedDays[day] == true) {
        activeDay = day;
      } else if (activeDay == day) {
        activeDay = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .92,
        child: SingleChildScrollView(
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
                const InspectorBottomSheetContainer(),
                Text(
                  widget.title,
                  style: getBoldStyle(color: ColorManager.black, fontSize: 24),
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
                BasicInfoSection(
                  clinicNameController: clinicNameController,
                  cityController: cityController,
                  consultationPriceController: consultationPriceController,
                  addressController: addressController,
                  locationController: locationController,
                  latitudeController: latitudeController,
                  longitudeController: longitudeController,
                  licenseController: licenseController,
                ),
                20.verticalSpace,
                ScheduleSection(
                  slotDurationController: slotDurationController,
                  maxPatientsController: maxPatientsController,
                  patientPerSlotController: patientPerSlotController,
                ),
                20.verticalSpace,
                WorkingDaysSection(
                  activeDay: activeDay,
                  weekDays: weekDays,
                  selectedDays: selectedDays,
                  openTimes: openTimes,
                  closeTimes: closeTimes,
                  onDayTap: onDayTap,
                  pickTime: ({required String day, required bool isOpen}) =>
                      pickTime(context: context, day: day, isOpen: isOpen),
                ),

                20.verticalSpace,

                const AiSuggestion(),

                10.verticalSpace,
                widget.isEdit
                    ? Column(
                        children: [
                          CustomBtn(text: "Save Changes", onPressed: () {}),

                          10.verticalSpace,
                          Center(
                            child: OutlineButton(
                              isEditSheet: true,
                              onPressed: () {},
                              title: "Delete Clinic",
                              color: ColorManager.error,
                            ),
                          ),
                        ],
                      )
                    : CustomBtn(text: "Add Clinic", onPressed: () {}),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
