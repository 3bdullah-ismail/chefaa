import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widget/custom_btn.dart';
import '../../../../../core/widget/custom_circle_avatar.dart';
import '../manager/booking_cubit.dart';
import '../manager/booking_state.dart';
import '../widgets/sub_text.dart';
import '../widgets/title_text.dart';

class ChooseVisitTime extends StatelessWidget {
  const ChooseVisitTime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final cubit = context.read<BookingCubit>();

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
                          const CustomCircleAvatar(
                            imagePath: ImageAssets.doctor,
                          ),
                          12.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.selectedClinic?.doctorName ??
                                      "No Clinic Selected",
                                  style: getBoldStyle(
                                    color: ColorManager.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  cubit.selectedClinic?.doctorSpecialty ?? "",
                                  style: getMediumStyle(
                                    color: ColorManager.gray,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${cubit.selectedClinic?.clinicPrice ?? ""} E£',
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
                        child: cubit.selectedClinic == null
                            ? const Center(child: Text("Select a clinic first"))
                            : !cubit.canChooseTime
                            ? const Center(child: Text("No available dates"))
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount:
                                    cubit.selectedClinic!.availableDays.length,
                                itemBuilder: (context, index) {
                                  final date = cubit
                                      .selectedClinic!
                                      .availableDays[index];
                                  final isSelected = DateUtils.isSameDay(
                                    date,
                                    cubit.selectedDay,
                                  );

                                  final double itemWidth = isSelected
                                      ? 85.w
                                      : 65.w;
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
                                          cubit.updateSelectedDate(date),
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
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
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
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
                                              date.day.toString().padLeft(
                                                2,
                                                '0',
                                              ),
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

                    if (state is GetSlotsLoadingState)
                      const Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                      )
                    else if (cubit.slots.isEmpty)
                      const Center(child: Text("No available time slots"))
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
                        itemCount: cubit.slots.length,
                        itemBuilder: (context, index) {
                          final slot = cubit.slots[index];

                          // هذا هو الوقت الذي سيرسل للـ API
                          final String apiTime = slot.startTime ?? "00:00";

                          // هذا فقط للعرض
                          final String displayTime = formatTime12Hour(apiTime);

                          final bool isSelected = cubit.selectedTime == apiTime;

                          return GestureDetector(
                            onTap: () => cubit.selectTime(apiTime),
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
                                      : ColorManager.input.withValues(
                                          alpha: 0.5,
                                        ),
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
                                displayTime,
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
                    32.verticalSpace,

                    if (cubit.selectedTime != null)
                      CustomBtn(
                        text: "Continue",
                        onPressed: () {
                          cubit.nextStep();
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

String formatTime12Hour(String time) {
  final date = DateFormat("HH:mm").parse(time);
  return DateFormat("hh:mm a").format(date);
}
