import 'package:flutter/material.dart';
import 'package:chefaa/core/resources/constants_manager.dart';
import 'package:chefaa/core/routes/app_routes_names.dart';

class RoleNavigationService {
  final BuildContext context;

  RoleNavigationService(this.context);

  void toLayout(String? role) {
    final route = _getLayoutRoute(role);
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }


  void toSignUp(String? role) {
    final navigationData = _getSignUpRoute(role);
    if (navigationData.route != null) {
      Navigator.pushReplacementNamed(
        context,
        navigationData.route!,
        arguments: navigationData.arguments,
      );
    }
  }

  void toLogin(String? role) {
    Navigator.pushNamed(
      context,
      AppRoutesNames.login,
      arguments: role,
    );
  }


  String _getLayoutRoute(String? role) {
    switch (role) {
      case 'doctor':
        return AppRoutesNames.doctorLayout;
      case 'pharmacy':
        return AppRoutesNames.pharmacyLayout;
      case 'facility':
        return AppRoutesNames.facilityLayout;
      case 'patient':
      default:
        return AppRoutesNames.patientLayout;
    }
  }

  ({String? route, dynamic arguments}) _getSignUpRoute(String? role) {
    switch (role) {
      case "patient":
        return (
        route: AppRoutesNames.patientSignUp,
        arguments: AppConstants.patient.toLowerCase()
        );
      case "doctor":
        return (route: AppRoutesNames.docSignUp, arguments: null);
      case "pharmacy":
        return (route: AppRoutesNames.pharmacySignUp, arguments: null);
      case "facility":
        return (route: AppRoutesNames.facilitySignUp, arguments: null);
      default:
        return (route: AppRoutesNames.option, arguments: null);
    }
  }
}