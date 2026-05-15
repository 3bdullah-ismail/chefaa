import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:chefaa/presentation/patient/layout/home/presentation/widgets/appointment_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/resources/values_manager.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: InsideAppBar(title: "My Appointments"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p18,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, _) => const DoctorCard(isAppointments: true),
          separatorBuilder: (_, _) => const SizedBox(height: 20),
          itemCount: 3,
        ),
      ),
    );
  }
}
