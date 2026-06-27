import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/patient/booking/presentation/manager/booking_cubit.dart';
import 'package:chefaa/presentation/patient/booking/presentation/manager/booking_state.dart';
import 'package:chefaa/presentation/patient/booking/presentation/pages/choose_doctor.dart';
import 'package:chefaa/presentation/patient/booking/presentation/pages/choose_visit_time.dart';
import 'package:chefaa/presentation/patient/booking/presentation/widgets/stepper_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/build_ex.dart';
import '../../../../../core/resources/color_manager.dart';
import 'confirm_booking.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final cubit = context.read<BookingCubit>();

        final pages = [
          const ChooseDoctor(),
          const ChooseVisitTime(),
          const ConfirmBooking(),
        ];

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(context.height * 0.17),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorManager.lightGray,
              elevation: 0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        cubit.previousStep();
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: ColorManager.black,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    24.verticalSpace,
                    Text(
                      'Book Appointment',
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    StepperHeader(activeStep: cubit.activeStep, totalSteps: 4),
                  ],
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: cubit.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pages.length,
                  onPageChanged: cubit.goToStep,
                  itemBuilder: (context, index) => pages[index],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

