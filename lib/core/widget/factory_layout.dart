import 'package:flutter/material.dart';

import '../../presentation/doctor/layout/presentation/pages/doctor_layout.dart';
import '../../presentation/patient/layout/presentation/pages/patient_layout.dart';

class LayoutFactory {
  static Widget getLayout(String role) {
    final lowerRole = role.toLowerCase(); // هنا نعمل toLowerCase على المتغير
    switch (lowerRole) {
      case 'patient': // هنا نكتب constant string
        return const PatientLayout();
      case 'doctor':
        return const DoctorLayout();
      default:
        return const PatientLayout();
    }
  }
}
