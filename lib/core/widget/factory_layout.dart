import 'package:flutter/material.dart';

import '../../presentation/doctor/layout/doctor_layout.dart';
import '../../presentation/patient/layout/presentation/pages/patient_layout.dart';

class LayoutFactory {
  static Widget getLayout(String role) {
    final lowerRole = role.toLowerCase();
    switch (lowerRole) {
      case 'patient':
        return const PatientLayout();
      case 'doctor':
        return const DoctorLayout();
      default:
        return const PatientLayout();
    }
  }
}
