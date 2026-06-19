import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widget/custom_btn.dart';
import '../manager/booking_cubit.dart';
import '../manager/booking_state.dart';
import '../widgets/sub_text.dart';
import '../widgets/title_text.dart';
import '../widgets/visit_type_card.dart';

class ChooseVisitTypePage extends StatelessWidget {
  const ChooseVisitTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final cubit = context.read<BookingCubit>();

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: REdgeInsets.symmetric(
                horizontal: 40,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.verticalSpace,
                  const TitleText(text: "Choose Visit Type"),
                  4.verticalSpace,

                  const SubText(
                    text:
                    "Select how you'd like to consult with the doctor",
                  ),

                  32.verticalSpace,

                  VisitTypeCard(
                    svgPath: "assets/svg_images/map.svg",
                    title: "Clinic Visit",
                    subtitle: " In-person consultation at clinic ",
                    isSelected:
                    cubit.selectedVisitType == VisitType.clinic,
                    onTap: () {
                      cubit.selectVisitType(VisitType.clinic);
                    },
                  ),

                  32.verticalSpace,

                  VisitTypeCard(
                    svgPath: "assets/svg_images/video.svg",
                    title: "Video Call",
                    subtitle: "Consult from comfort of home ",
                    isSelected:
                    cubit.selectedVisitType == VisitType.online,
                    onTap: () {
                      cubit.selectVisitType(VisitType.online);
                    },
                  ),

                  32.verticalSpace,

                  if (cubit.selectedVisitType != null)
                    CustomBtn(
                      text: "Next",
                      onPressed: () {
                        cubit.nextStep();
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

enum VisitType {
  clinic,
  online,
}