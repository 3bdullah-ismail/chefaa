import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/widget/custom_btn.dart';
import '../manager/booking_provider.dart';
import '../widgets/sub_text.dart';
import '../widgets/title_text.dart';
import '../widgets/visit_type_card.dart';

class ChooseVisitTypePage extends StatefulWidget {
  const ChooseVisitTypePage({super.key});

  @override
  State<ChooseVisitTypePage> createState() => _ChooseVisitTypePageState();
}

class _ChooseVisitTypePageState extends State<ChooseVisitTypePage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 40, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              30.verticalSpace,
              const TitleText(text: "Choose Visit Type"),
              4.verticalSpace,

              const SubText(
                text: "Select how you'd like to consult with the doctor",
              ),
              32.verticalSpace,

              VisitTypeCard(
                svgPath: "assets/svg_images/map.svg",
                title: "Clinic Visit",
                subtitle: " In-person consultation at clinic ",
                isSelected: provider.selectedVisitType == VisitType.clinic,
                onTap: () => provider.onSelect(VisitType.clinic),
              ),
              32.verticalSpace,
              VisitTypeCard(
                svgPath: "assets/svg_images/video.svg",
                title: "Video Call",
                subtitle: "Consult from comfort of home ",
                isSelected: provider.selectedVisitType == VisitType.online,
                onTap: () => provider.onSelect(VisitType.online),
              ),
              32.verticalSpace,
              provider.selectedVisitType != null
                  ? CustomBtn(
                      text: "Next",
                      onPressed: () {
                        if (provider.selectedVisitType == VisitType.clinic) {
                          provider.nextStep();
                        } else {
                          provider.nextStep();
                        }
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

enum VisitType { clinic, online }
