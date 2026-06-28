import 'package:chefaa/features/doctor/layout/home/presentation/pages/clinic_details_page.dart';
import 'package:chefaa/features/doctor/layout/home/presentation/pages/clinics_page.dart';
import 'package:chefaa/features/patient/checkout_order/presentation/pages/checkout_page.dart';
import 'package:chefaa/features/patient/order/presentation/pages/track_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chefaa/core/config/get_config.dart';
import 'package:chefaa/features/facility/auth/presentation/pages/facility_sign_up_page.dart';
import 'package:chefaa/features/facility/dashboard/presentation/pages/facility_results_page.dart';
import 'package:chefaa/features/facility/dashboard/presentation/pages/create_patient_request_page.dart';
import 'package:chefaa/features/facility/layout/presentation/pages/facility_layout_page.dart';
import 'package:chefaa/features/auth/presentation/pages/forget_password_page.dart';
import 'package:chefaa/features/auth/presentation/pages/login_page.dart';
import 'package:chefaa/features/auth/presentation/pages/reset_code_page.dart';
import 'package:chefaa/features/auth/presentation/pages/reset_password_page.dart';
import 'package:chefaa/features/entry/presentation/pages/chefaa_entry_page.dart';
import 'package:chefaa/features/doctor/auth/presentation/pages/doctor_sign_up_page.dart';
import 'package:chefaa/features/doctor/layout/doctor_layout.dart';
import 'package:chefaa/features/doctor/layout/patients/presentation/pages/patient_details.dart';
import 'package:chefaa/features/onboarding/presentation/pages/facility_option.dart';
import 'package:chefaa/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:chefaa/features/onboarding/presentation/pages/option_screen.dart';
import 'package:chefaa/features/patient/ai_lab/presentation/pages/ai_lab_analysis.dart';
import 'package:chefaa/features/patient/ai_lab/presentation/pages/history_report_page.dart';
import 'package:chefaa/features/patient/auth/presentation/pages/patient_sign_up_page.dart';
import 'package:chefaa/features/patient/booking/presentation/pages/choose_doctor_page.dart';
import 'package:chefaa/features/patient/complete_auth_data/presentation/manager/complete_cubit.dart';
import 'package:chefaa/features/patient/complete_auth_data/presentation/pages/first_complete_page.dart';
import 'package:chefaa/features/patient/complete_auth_data/presentation/pages/last_complete_data.dart';
import 'package:chefaa/features/patient/complete_auth_data/presentation/pages/second_complete_page.dart';
import 'package:chefaa/features/patient/appointment/presentation/pages/appointment_page.dart';
import 'package:chefaa/features/patient/medication/presentation/pages/medication_page.dart';
import 'package:chefaa/features/patient/lab_search/presentation/pages/find_lab_page.dart';
import 'package:chefaa/features/patient/layout/presentation/pages/patient_layout.dart';
import 'package:chefaa/features/patient/payment/presentation/pages/payment_page.dart';
import 'package:chefaa/features/patient/pharmacy/pharmacies/presentation/pages/pharmacy_layout.dart';
import 'package:chefaa/features/patient/search/presentation/pages/location_filter.dart';
import 'package:chefaa/features/patient/search/presentation/pages/search_page.dart';
import 'package:chefaa/features/patient/search/presentation/pages/speciality_page.dart';
import 'package:chefaa/features/pharmacy/auth/presentation/pages/pharmacy_sign_up_page.dart';
import 'package:chefaa/features/pharmacy/layout/presentation/pages/pharmacy_layout.dart';
import 'package:chefaa/features/patient/lab_results/presentation/pages/lab_results_page.dart';
import 'package:chefaa/features/patient/lab_results/presentation/manager/lab_results_cubit.dart';
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
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(
            PaymentPage(
              orderId: args?['orderId'] as String? ?? "",
              subtotal: (args?['subtotal'] as num?)?.toDouble() ?? 0.0,
              deliveryFee: (args?['deliveryFee'] as num?)?.toDouble() ?? 0.0,
            ),
          ),
        );
      case AppRoutesNames.trackOrderPage:
        final orderId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => _wrapWithCanPop(TrackOrderPage(orderId: orderId)),
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
