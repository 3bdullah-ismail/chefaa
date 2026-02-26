import 'package:flutter/material.dart';
import '../../presentation/Facility/auth/presentation/pages/facility_signup.dart';
import '../../presentation/auth/presentation/pages/forget_password.dart';
import '../../presentation/auth/presentation/pages/reset_code.dart';
import '../../presentation/auth/presentation/pages/reset_password.dart';
import '../../presentation/doctor/auth/presentation/pages/doctor_sing_up.dart';
import '../../presentation/layout/presentation/pages/layout_page.dart';
import '../../presentation/onboarding/pages/facility_option.dart';
import '../../presentation/onboarding/pages/onboarding_page.dart';
import '../../presentation/onboarding/pages/option_screen.dart';
import '../../presentation/patient/auth/presentation/pages/patient_sign_up_page.dart';
import '../../presentation/patient/complete_auth_data/presentation/pages/first_complete_page.dart';
import '../../presentation/patient/complete_auth_data/presentation/pages/last_complete_data.dart';
import '../../presentation/patient/complete_auth_data/presentation/pages/second_complete_page.dart';
import '../../presentation/pharmacy/auth/presentation/pages/pharmacy_sign_up_page.dart';
import 'app_routes_names.dart';

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
      case AppRoutesNames.patientSignUpCompleteChronicDiseases:
        return MaterialPageRoute(builder: (_) => const SecondCompletePage());
      case AppRoutesNames.patientSignUpCompleteMedicines:
        return MaterialPageRoute(builder: (_) => const LastCompleteData());
      case AppRoutesNames.layout:
        return MaterialPageRoute(builder: (_) => const LayoutPage());
      case AppRoutesNames.resetCode:
        int index = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => ResetCode(index: index));
      case AppRoutesNames.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPassword());
      case AppRoutesNames.patientSignUpCompleteData:
        return MaterialPageRoute(builder: (_) => const FirstCompletePage());
      case AppRoutesNames.pharmacySignUp:
        return MaterialPageRoute(builder: (_) => const PharmacySignUpPage());
      case AppRoutesNames.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text("404 not found"))),
        );
    }
  }
}
