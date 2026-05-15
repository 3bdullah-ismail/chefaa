import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widget/custom_btn.dart';
import '../../../../../core/widget/custom_circle_avatar.dart';
import '../manager/booking_provider.dart';
import '../widgets/sub_text.dart';
import '../widgets/title_text.dart';

class ChooseVisitTime extends StatelessWidget {
  const ChooseVisitTime({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleText(text: "Choose Time Slot"),
                8.verticalSpace,
                const SubText(text: "Select your preferred date and time"),
                16.verticalSpace,

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: ColorManager.input),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CustomCircleAvatar(imagePath: ImageAssets.doctor),
                      12.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.selectedClinic?.doctorName ??
                                  "No Clinic Selected",
                              style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              provider.selectedClinic?.doctorSpecialty ?? "",
                              style: getMediumStyle(
                                color: ColorManager.gray,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${provider.selectedClinic?.clinicPrice ?? ""} E£',
                        style: getSemiBoldStyle(
                          color: ColorManager.primary,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                32.verticalSpace,
                const TitleText(text: "Select Date"),
                16.verticalSpace,

                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 110.h,
                    child: provider.selectedClinic == null
                        ? const Center(child: Text("Select a clinic first"))
                        : !provider.canChooseTime
                        ? const Center(child: Text("No available dates"))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount:
                                provider.selectedClinic!.availableDays.length,
                            itemBuilder: (context, index) {
                              final date =
                                  provider.selectedClinic!.availableDays[index];
                              final isSelected = DateUtils.isSameDay(
                                date,
                                provider.selectedDate,
                              );

                              final double itemWidth = isSelected ? 85.w : 65.w;
                              final double itemHeight = isSelected
                                  ? 100.h
                                  : 80.h;

                              final double dayFontSize = isSelected
                                  ? 16.sp
                                  : 14.sp;
                              final double dateFontSize = isSelected
                                  ? 20.sp
                                  : 18.sp;

                              return Center(
                                child: GestureDetector(
                                  onTap: () =>
                                      provider.updateSelectedDate(date),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,

                                    width: itemWidth,
                                    height: itemHeight,

                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? ColorManager.primary
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isSelected
                                            ? ColorManager.primary
                                            : ColorManager.input.withValues(
                                                alpha: 0.5,
                                              ),
                                      ),

                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: ColorManager.primary
                                                    .withValues(alpha: 0.2),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat('EEE').format(date),
                                          style: getMediumStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : ColorManager.gray,
                                            fontSize: dayFontSize,
                                          ),
                                        ),
                                        4.verticalSpace,
                                        Text(
                                          date.day.toString().padLeft(2, '0'),
                                          style: getBoldStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : ColorManager.black,
                                            fontSize: dateFontSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
                32.verticalSpace,
                const TitleText(text: "Available time"),
                16.verticalSpace,
                if (!provider.canChooseTime)
                  const Center(
                    child: Text("Select a clinic with available dates"),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 2.8,
                    ),

                    itemCount: 6,
                    itemBuilder: (context, index) {
                      final List<String> times = [
                        "08:00 AM",
                        "09:00 AM",
                        "10:00 AM",
                        "11:00 AM",
                        "12:00 AM",
                        "01:00 PM",
                      ];
                      final String time = times[index];
                      final bool isSelected = provider.selectedTime == time;

                      return GestureDetector(
                        onTap: () => provider.updateSelectedTime(time),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ColorManager.primary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? ColorManager.primary
                                  : ColorManager.input.withValues(alpha: 0.5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            time,
                            style: getMediumStyle(
                              color: isSelected
                                  ? Colors.white
                                  : ColorManager.gray,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                32.verticalSpace,
                if (provider.canChooseTime && provider.selectedTime != null)
                  CustomBtn(
                    text: "Continue",
                    onPressed: () {
                      provider.nextStep();
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
