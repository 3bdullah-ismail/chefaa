import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:chefaa/presentation/Facility/auth/presentation/pages/facility_signup.dart';
import 'package:chefaa/presentation/onboarding/pages/Facility_option.dart';
import 'package:chefaa/presentation/onboarding/pages/onboarding_page.dart';
import 'package:chefaa/presentation/onboarding/pages/option_screen.dart';
import 'package:flutter/material.dart';

import '../../presentation/doctor/auth/presentation/pages/singup.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case AppRoutesNames.option:
        return MaterialPageRoute(builder: (_) => const OptionScreen());
      case AppRoutesNames.facilityOption:
        return MaterialPageRoute(builder: (_) => const FacilityOptionScreen());
      case AppRoutesNames.docSignUp:
        return MaterialPageRoute(builder: (_) => const DocSignUp());
      case AppRoutesNames.facilitySignUp:
        return MaterialPageRoute(builder: (_) => const FacilitySignup());
      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text("404 not found"))),
        );
    }
  }
}
