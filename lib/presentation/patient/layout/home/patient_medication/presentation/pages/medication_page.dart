import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/add_medication.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/medication_card.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/over_view_card.dart';
import 'package:chefaa/presentation/patient/layout/home/patient_medication/presentation/widgets/suggest_card.dart';
import 'package:chefaa/presentation/patient/layout/home/presentation/widgets/ai_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/bottom_sheet.dart';

class MedicationPage extends StatelessWidget {
  const MedicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: InsideAppBar(
          title: "My Medications ",
          subtitle: "Track and manage your medication schedule",
          height: 130,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppPadding.p32,
            left: AppPadding.p20,
            right: AppPadding.p20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OverViewCard(label: "Avg.Adherence", title: "92%"),
                  OverViewCard(
                    label: "Active Medications",
                    title: "3",
                    isActive: true,
                  ),
                ],
              ),
              const SuggestCard(),
             5.verticalSpace,
              Row(
                children: [
                  Text(
                    "Medications",
                    style: getMediumStyle(
                      color: ColorManager.black,
                    ).copyWith(fontSize: 20),
                  ),
                  const Spacer(),
                  AddMedication(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: ColorManager.lightGray,
                        isScrollControlled: true,
                        builder: (BuildContext context) =>const  FractionallySizedBox(
                          heightFactor: 0.92,
                          child:  BottomSheetCard(
                            title: "Edit Medication",
                            content:
                                "Update your medication details.",
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
               MedicationCard(onPressed: ()
                 {
                   showModalBottomSheet(
                     context: context,
                     backgroundColor: ColorManager.lightGray,
                     isScrollControlled: true,
                     builder: (BuildContext context) =>const  FractionallySizedBox(
                       heightFactor: 0.92,
                       child:  BottomSheetCard(
                         edition: true,
                         title: "Edit Medication",
                         content:
                         "Update your medication details.",
                       ),
                     ),
                   );
                 }
               ,),
               MedicationCard(onPressed: ()  {
                 showModalBottomSheet(
                   context: context,
                   backgroundColor: ColorManager.lightGray,
                   isScrollControlled: true,
                   builder: (BuildContext context) =>const  FractionallySizedBox(
                     heightFactor: 0.92,
                     child:  BottomSheetCard(
                       edition: true,
                       title: "Edit Medication",
                       content:
                       "Update your medication details.",
                     ),
                   ),
                 );
               }),
              const AiSuggestion(),
               MedicationCard(
                   onPressed: ()  {
                 showModalBottomSheet(
                   context: context,
                   backgroundColor: ColorManager.lightGray,
                   isScrollControlled: true,
                   builder: (BuildContext context) =>const  FractionallySizedBox(
                     heightFactor: 0.92,
                     child:  BottomSheetCard(
                       edition: true,
                       title: "Add Medication",
                       content:
                       "Enter your medication details for tracking and reminders",
                     ),
                   ),
                 );
               }),
            5.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
