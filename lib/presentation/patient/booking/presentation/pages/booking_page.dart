import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/patient/booking/presentation/pages/choose_doctor.dart';
import 'package:chefaa/presentation/patient/booking/presentation/pages/choose_visit_type.dart';
import 'package:chefaa/presentation/patient/booking/presentation/widgets/stepper_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/extensions/build_ex.dart';
import '../../../../../core/resources/color_manager.dart';
import '../manager/booking_provider.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();

    final pages = [
      const ChooseVisitTypePage(),
      if (provider.selectedVisitType == VisitType.clinic)
        const Center(child: Text("Clinic Details Page"))
      else if (provider.selectedVisitType == VisitType.online)
        const ChooseDoctor(),
      const Center(child: Text("Chat")),
      const Center(child: Text("Chat")),
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
                Text(
                  'Book Appointment',
                  style: getBoldStyle(color: ColorManager.black, fontSize: 24),
                ),
                const SizedBox(height: 16),
                StepperHeader(activeStep: provider.activeStep, totalSteps: 4),
              ],
            ),
          ),

          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: provider.pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pages.length,
              onPageChanged: (index) {
                provider.goToStep(index);
              },
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
