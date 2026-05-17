import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/widgets/custom_switch_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/values_manager.dart';
import '../widgets/patient_card.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  int selectedIndex = 0;

  List upcomingPatients = [
    {"name": "Ahmed Omar ", "lastVisit": "01/01/2024"},
    {"name": "Sara Hashem", "lastVisit": "15/02/2024"},
    {"name": "Omar Rafat", "lastVisit": "20/03/2024"},
    {"name": "Mona Ali", "lastVisit": "10/04/2024"},
  ];
  List completedPatients = [
    {"name": "Fares Samwel", "lastVisit": "01/01/2024"},
    {"name": "Asmaa Ragab", "lastVisit": "15/02/2024"},
    {"name": "Abeer Osama", "lastVisit": "20/03/2024"},
    {"name": "Hanaa Ahmed", "lastVisit": "10/04/2024"},
  ];

  List get currentList {
    return selectedIndex == 0 ? upcomingPatients : completedPatients;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: InsideAppBar(title: ' My Patients ',isLayout: true,),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: AppPadding.p32,
          left: AppPadding.p18,
          right: AppPadding.p18,
        ),
        child: Column(
          children: [
            CustomSwitchTab(
              items: const ['Upcoming', 'Completed'],
              onChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: AppPadding.p18),
                separatorBuilder: (context, index) => 10.verticalSpace,
                itemCount: currentList.length,
                itemBuilder: (context, index) {
                  final patient = currentList[index];

                  return PatientCard(

                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutesNames.patientDetailsPage,
                      );
                    },
                    name: patient["name"],
                    lastVisit: patient["lastVisit"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
