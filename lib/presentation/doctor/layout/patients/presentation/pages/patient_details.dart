import 'package:chefaa/core/widget/inside_app_bar.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/widgets/patient_data_card.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/widgets/prescription_card.dart';
import 'package:chefaa/presentation/doctor/layout/patients/presentation/widgets/prescription_history.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/values_manager.dart';
import '../widgets/custom_switch_tab.dart';

class PatientDetailsPage extends StatefulWidget {
  const PatientDetailsPage({super.key});

  @override
  State<PatientDetailsPage> createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
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
        preferredSize:  Size.fromHeight(100),
        child: InsideAppBar(title: 'Patient Details',isLayout: true ,),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: AppPadding.p32,
          left: AppPadding.p12,
          right: AppPadding.p12,
        ),
        child: Column(
          children: [
            CustomSwitchTab(
              items: const ['Prescription', 'Patient Data', 'History'],
              onChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),

            const SizedBox(height: 10),

            Expanded(
              child:_buildContent(),
            ),
          ],
        ),
      )
    );
  }
  Widget _buildContent() {
    switch (selectedIndex) {
      case 0:
        return const PrescriptionCard(
      medications:[
        {
        "name": "Amoxicillin",
        "dosage": "500 mg",
        "frequency": "Every 8 hours",
        "duration": "7 days",
        },
        {
        "name": "Ibuprofen",
        "dosage": "200 mg",
        "frequency": "Twice daily after meals",
        "duration": "5 days",
        },
        {
        "name": "Salbutamol Inhaler",
        "dosage": "2 puffs",
        "frequency": "As needed",
        "duration": " Use for 2 weeks",
        },
        {
        "name": "Cetirizine",
        "dosage": "10 mg",
        "frequency": "Once daily at night",
        "duration": "10 days",
        },
        ],
        );
      case 1:
        return const PatientDataCard();
      case 2:
        return const PrescriptionHistory();
      default:
        return const SizedBox();
    }
  }
}
