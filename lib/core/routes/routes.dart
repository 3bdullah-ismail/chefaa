import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/get_config.dart';
import '../../presentation/Facility/auth/presentation/pages/facility_signup.dart';
import '../../presentation/Facility/layout/presentation/pages/facility_layout.dart';
import '../../presentation/auth/presentation/pages/forget_password.dart';
import '../../presentation/auth/presentation/pages/login_page.dart';
import '../../presentation/auth/presentation/pages/reset_code.dart';
import '../../presentation/auth/presentation/pages/reset_password.dart';
import '../../presentation/chefaa_entry_page.dart';
import '../../presentation/doctor/auth/presentation/pages/doctor_sing_up.dart';
import '../../presentation/doctor/layout/presentation/pages/doctor_layout.dart';
import '../../presentation/onboarding/pages/facility_option.dart';
import '../../presentation/onboarding/pages/onboarding_page.dart';
import '../../presentation/onboarding/pages/option_screen.dart';
import '../../presentation/patient/ai_lab/presentation/pages/ai_lab_analysis.dart';
import '../../presentation/patient/ai_lab/presentation/pages/history_report_page.dart';
import '../../presentation/patient/auth/presentation/pages/patient_sign_up_page.dart';
import '../../presentation/patient/booking/presentation/pages/choose_doctor.dart';
import '../../presentation/patient/complete_auth_data/presentation/manager/complete_cubit.dart';
import '../../presentation/patient/complete_auth_data/presentation/pages/first_complete_page.dart';
import '../../presentation/patient/complete_auth_data/presentation/pages/last_complete_data.dart';
import '../../presentation/patient/complete_auth_data/presentation/pages/second_complete_page.dart';
import '../../presentation/patient/layout/home/patient_appointment/presentation/pages/appointment_page.dart';
import '../../presentation/patient/layout/home/patient_medication/presentation/pages/medication_page.dart';
import '../../presentation/patient/layout/patient_layout.dart';
import '../../presentation/patient/search/presentation/pages/location_filter.dart';
import '../../presentation/patient/search/presentation/pages/search_page.dart';
import '../../presentation/patient/search/presentation/pages/speciality_page.dart';
import '../../presentation/pharmacy/auth/presentation/pages/pharmacy_sign_up_page.dart';
import '../../presentation/pharmacy/layout/presentation/pages/pharmacy_layout.dart';
import 'app_routes_names.dart';

class Routes {
  // Wrap pages so the back button exits the app when there is no previous route.
  static Widget _wrapWithCanPop(Widget page) {
    return Builder(
      builder: (context) {
        final canPop = Navigator.of(context).canPop();
        return PopScope(
          canPop: canPop,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            if (!Navigator.of(context).canPop()) {
              SystemNavigator.pop();
            }
          },
          child: page,
        );
      },
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.login:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const LoginPage()),
        );
      case AppRoutesNames.onboardingRoute:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const OnboardingPage()),
        );
      case AppRoutesNames.option:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const OptionScreen()),
        );
      case AppRoutesNames.appEntryRoute:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const ChefaaEntryPage()),
        );
      case AppRoutesNames.docSignUp:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const DocSignUp()),
        );
      case AppRoutesNames.facilitySignUp:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const FacilitySignup()),
        );
      case AppRoutesNames.facilityOption:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const FacilityOptionScreen()),
        );
      case AppRoutesNames.patientSignUp:
        {
          final arg = settings.arguments;
          if (arg is! String) {
            return MaterialPageRoute(
              builder: (_) => _wrapWithCanPop(
                const Scaffold(
                  body: Center(
                    child: Text('Missing/invalid route argument: role'),
                  ),
                ),
              ),
            );
          }
          final role = arg;
          return MaterialPageRoute(
            builder: (_) => _wrapWithCanPop(PatientSignUpPage(role: role)),
          );
        }
       case AppRoutesNames.patientSignUpCompleteChronicDiseases:
         return MaterialPageRoute(
           builder: (context) => _wrapWithCanPop(
             BlocProvider(
               create: (_) => getIt<CompleteCubit>(),
               child: const SecondCompletePage(),
             ),
           ),
         );
       case AppRoutesNames.patientSignUpCompleteMedicines:
         return MaterialPageRoute(
           builder: (context) => _wrapWithCanPop(
             BlocProvider(
               create: (_) => getIt<CompleteCubit>(),
               child: const LastCompleteData(),
             ),
           ),
         );
      case AppRoutesNames.resetCode:
        {
          final arg = settings.arguments;
          if (arg is! int) {
            return MaterialPageRoute(
              builder: (_) => _wrapWithCanPop(
                const Scaffold(
                  body: Center(
                    child: Text('Missing/invalid route argument: index'),
                  ),
                ),
              ),
            );
          }
          final int index = arg;
          return MaterialPageRoute(
            builder: (_) => _wrapWithCanPop(ResetCode(index: index)),
          );
        }
      case AppRoutesNames.resetPassword:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const ResetPassword()),
        );
      case AppRoutesNames.historyReportPage:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const ReportsHistoryPage()),
        );
       case AppRoutesNames.patientSignUpCompleteData:
         return MaterialPageRoute(
           builder: (context) => _wrapWithCanPop(
             BlocProvider(
               create: (_) => getIt<CompleteCubit>(),
               child: const FirstCompletePage(),
             ),
           ),
         );
      case AppRoutesNames.pharmacySignUp:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const PharmacySignUpPage()),
        );
      case AppRoutesNames.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const ForgetPassword()),
        );

      case AppRoutesNames.patientLayout:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const PatientLayout()),
        );
      case AppRoutesNames.aiLabAnalysis:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const AILabAnalysis()),
        );
      case AppRoutesNames.appointmentPage:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const AppointmentPage()),
        );
      case AppRoutesNames.specialityPage:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const SpecialityPage()),
        );
      case AppRoutesNames.patientSearch:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const SearchPage()),
        );
      case AppRoutesNames.medicationPage:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const MedicationPage()),
        );
      case AppRoutesNames.doctorLayout:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const DoctorLayout()),
        );
      case AppRoutesNames.pharmacyLayout:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const PharmacyLayout()),
        );
      case AppRoutesNames.facilityLayout:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const FacilityLayout()),
        );
      case AppRoutesNames.chooseDoctor:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const ChooseDoctor()),
        );
      case AppRoutesNames.locationFilter:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const LocationFilter()),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(
            const Scaffold(body: Center(child: Text("404 not found"))),
          ),
        );
    }
  }
}
