import 'package:chefaa/presentation/doctor/layout/home/presentation/pages/clinic_details_page.dart';
import 'package:chefaa/presentation/doctor/layout/home/presentation/pages/clinics_page.dart';
import 'package:chefaa/presentation/patient/checkout_order/presentation/pages/checkout_page.dart';
import 'package:chefaa/presentation/patient/order/presentation/pages/track_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/get_config.dart';
import '../../presentation/facility/auth/presentation/pages/facility_signup.dart';
import '../../presentation/facility/dashboard/presentation/pages/facility_results_page.dart';
import '../../presentation/facility/dashboard/presentation/pages/create_patient_request_page.dart';
import '../../presentation/facility/layout/presentation/pages/facility_layout.dart';
import '../../presentation/auth/presentation/pages/forget_password.dart';
import '../../presentation/auth/presentation/pages/login_page.dart';
import '../../presentation/auth/presentation/pages/reset_code.dart';
import '../../presentation/auth/presentation/pages/reset_password.dart';
import '../../presentation/chefaa_entry_page.dart';
import '../../presentation/doctor/auth/presentation/pages/doctor_sing_up.dart';
import '../../presentation/doctor/layout/doctor_layout.dart';
import '../../presentation/doctor/layout/patients/presentation/pages/patient_details.dart';
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
import '../../presentation/patient/appointment/presentation/pages/appointment_page.dart';
import '../../presentation/patient/medication/presentation/pages/medication_page.dart';
import '../../presentation/patient/lab_search/presentation/pages/find_lab_page.dart';
import '../../presentation/patient/layout/presentation/pages/patient_layout.dart';
import '../../presentation/patient/payment/presentation/pages/payment_page.dart';
import '../../presentation/patient/pharmacy/pharmacies/presentation/pages/pharmacy_layout.dart';
import '../../presentation/patient/search/presentation/pages/location_filter.dart';
import '../../presentation/patient/search/presentation/pages/search_page.dart';
import '../../presentation/patient/search/presentation/pages/speciality_page.dart';
import '../../presentation/pharmacy/auth/presentation/pages/pharmacy_sign_up_page.dart';
import '../../presentation/pharmacy/layout/presentation/pages/pharmacy_layout.dart';
import 'package:chefaa/presentation/patient/lab_results/presentation/pages/lab_results_page.dart';
import 'package:chefaa/presentation/patient/lab_results/presentation/manager/lab_results_cubit.dart';
import 'app_routes_names.dart';

class Routes {
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
      case AppRoutesNames.clinicsPage:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const ClinicsPage()),
        );
      case AppRoutesNames.clinicsDetailsPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => _wrapWithCanPop(const ClinicDetailsPage()),
        );
      case AppRoutesNames.searchPharmacy:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const MainLayout()),
        );
      case AppRoutesNames.option:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const OptionScreen()),
        );
      case AppRoutesNames.checkoutPage:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const CheckoutPage()),
        );
      case AppRoutesNames.paymentPage:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const PaymentPage()),
        );
      case AppRoutesNames.trackOrderPage:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const TrackOrderPage()),
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
      case AppRoutesNames.findLabPage:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const FindLabPage()),
        );
      case AppRoutesNames.doctorLayout:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const DoctorLayout()),
        );
      case AppRoutesNames.patientDetailsPage:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const PatientDetailsPage()),
        );
      case AppRoutesNames.pharmacyLayout:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const PharmacyLayout()),
        );
      case AppRoutesNames.facilityLayout:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const FacilityLayout()),
        );
      case AppRoutesNames.facilityResults:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const FacilityResultsPage()),
        );
      case AppRoutesNames.createPatientRequest:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const CreatePatientRequestPage()),
        );
      case AppRoutesNames.chooseDoctor:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const ChooseDoctor()),
        );
      case AppRoutesNames.locationFilter:
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(const LocationFilter()),
        );
      case AppRoutesNames.labResultsPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<LabResultsCubit>()..getLabResults(),
            child: _wrapWithCanPop(const LabResultsPage()),
          ),
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
