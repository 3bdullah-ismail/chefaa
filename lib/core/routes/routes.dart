import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:chefaa/presentation/Facility/auth/presentation/pages/facility_signup.dart';
import 'package:chefaa/presentation/onboarding/pages/Facility_option.dart';
import 'package:chefaa/presentation/onboarding/pages/onboarding_page.dart';
import 'package:chefaa/presentation/onboarding/pages/option_screen.dart';
import 'package:chefaa/presentation/patient/complete_auth_data/presentation/pages/last_complete_data.dart';
import 'package:chefaa/presentation/patient/complete_auth_data/presentation/pages/second_complete_page.dart';
import 'package:flutter/material.dart';

import '../../presentation/doctor/auth/presentation/pages/singup.dart';
import '../../presentation/layout/presentation/pages/layout_page.dart';
import '../../presentation/patient/auth/presentation/pages/patient_sign_up_page.dart';
import '../../presentation/patient/auth/presentation/pages/sign_up_complete_page.dart';
import '../../presentation/patient/complete_auth_data/presentation/pages/first_complete_page.dart';
import '../../presentation/pharmacy/auth/presentation/pages/pharmacy_sign_up_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case AppRoutesNames.option:
        return MaterialPageRoute(builder: (_) => const OptionScreen());
      case AppRoutesNames.docSignUp:
        return MaterialPageRoute(builder: (_) => const DocSignUp());
      case AppRoutesNames.facilitySignUp:
        return MaterialPageRoute(builder: (_) => const FacilitySignup());
      case AppRoutesNames.facilityOption:
        return MaterialPageRoute(builder: (_) => const FacilityOptionScreen());
      case AppRoutesNames.patientSignUp:
        final role = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => PatientSignUpPage(role: role));
      case AppRoutesNames.patientSignUpComplete:
        return MaterialPageRoute(builder: (_) => const SignUpCompletePage());

      case AppRoutesNames.patientSignUpCompleteChronicDiseases:
        final args = settings.arguments as List<dynamic>;
        final weight = args[0] as double;
        final height = args[1] as int;
        final bloodType = args[2] as String;
        final gender = args[3] as String;
        final birthDate = args[4] as DateTime;

        return MaterialPageRoute(
          builder: (_) => SecondCompletePage(
            weight: weight,
            height: height,
            bloodType: bloodType,
            gender: gender,
            birthDate: birthDate,
          ),
        );

      case AppRoutesNames.patientSignUpCompleteMedicines:
        final args = settings.arguments as List<dynamic>;
        final weight = args[0] as double;
        final height = args[1] as int;
        final bloodType = args[2] as String;
        final gender = args[3] as String;
        final birthDate = args[4] as DateTime;
        final chronicDiseases = args[5] as List<String>;

        return MaterialPageRoute(
          builder: (_) => LastCompleteData(
            weight: weight,
            height: height,
            bloodType: bloodType,
            gender: gender,
            birthDate: birthDate,
            chronicDiseases: chronicDiseases,
          ),
        );

      case AppRoutesNames.layout:
        return MaterialPageRoute(builder: (_) => const LayoutPage());

      case AppRoutesNames.patientSignUpCompleteData:
        return MaterialPageRoute(builder: (_) => const FirstCompletePage());

      case AppRoutesNames.pharmacySignUp:
        return MaterialPageRoute(builder: (_) => const PharmacySignUpPage());

      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text("404 not found"))),
        );
    }
  }
}
