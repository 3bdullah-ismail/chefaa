import 'package:chefaa/core/routes/app_routes_names.dart';
import 'package:chefaa/presentation/onboarding/pages/onboarding_page.dart';
import 'package:chefaa/presentation/onboarding/pages/option_screen.dart';
import 'package:chefaa/presentation/pharmacy/presentation/pages/pharmacy_sign_up_page.dart';
import 'package:flutter/material.dart';

import '../../presentation/doctor/auth/presentation/pages/singup.dart';
import '../../presentation/layout/presentation/pages/layout_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case AppRoutesNames.option:
        return MaterialPageRoute(builder: (_) => const OptionScreen());
      case AppRoutesNames.docSignUp:
        return MaterialPageRoute(builder: (_) => const DocSignUp());
        case AppRoutesNames.pharmacySignUp:
        return MaterialPageRoute(builder: (_) => const PharmacySignUpPage());

      case AppRoutesNames.layout:
        return MaterialPageRoute(builder: (_) => const LayoutPage());
      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text("404 not found"))),
        );
    }
  }
}
