import 'package:flutter/material.dart';

import '../../../search/domain/entities/clinic_model.dart';
import '../pages/choose_visit_type.dart';

enum PaymentMethod { creditCard, cash }

class BookingProvider extends ChangeNotifier {
  int activeStep = 0;

  final PageController pageController = PageController();
  ClinicModel? selectedClinic;

  bool selectClinicAndNext(ClinicModel clinic) {
    selectedClinic = clinic;
    selectedTime = null;
    selectedVisitType = null;
    selectedPaymentMethod = null;
    showCardForm = false;
    selectedDate = clinic.availableDays.isNotEmpty
        ? clinic.availableDays.first
        : DateTime.now();

    notifyListeners();

    if (clinic.availableDays.isEmpty) {
      return false;
    }

    nextStep();
    return true;
  }

  void selectDoctorAndNext(ClinicModel doctor) {
    selectClinicAndNext(doctor);
  }

  String? selectedTime;

  void updateSelectedTime(String time) {
    selectedTime = time;
    notifyListeners();
  }

  DateTime selectedDate = DateTime.now();

  bool get hasAvailableDates =>
      selectedClinic?.availableDays.isNotEmpty ?? false;

  bool get canChooseTime => selectedClinic != null && hasAvailableDates;

  void updateSelectedDate(DateTime date) {
    if (!hasAvailableDates) return;
    final availableDays = selectedClinic!.availableDays;
    final isAllowed = availableDays.any(
      (day) => DateUtils.isSameDay(day, date),
    );
    if (!isAllowed) return;

    selectedDate = date;
    notifyListeners();
  }

  void nextStep() {
    if (activeStep < 3) {
      activeStep++;
      pageController.animateToPage(
        activeStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
    if (!canChooseTime) return;
  }

  void previousStep() {
    if (activeStep > 0) {
      activeStep--;
      pageController.animateToPage(
        activeStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void goToStep(int step) {
    activeStep = step;
    pageController.jumpToPage(step);
    notifyListeners();
  }

  VisitType? selectedVisitType;

  void onSelect(VisitType type) {
    selectedVisitType = type;
    notifyListeners();
  }

  String getVisitType() {
    if (selectedVisitType == VisitType.online) {
      return "Video Call";
    } else if (selectedVisitType == VisitType.clinic) {
      return "Clinic Visit";
    } else {
      return "No Visit Type Selected";
    }
  }

  PaymentMethod? selectedPaymentMethod;
  bool showCardForm = false;

  final GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  bool get needsCard => selectedPaymentMethod == PaymentMethod.creditCard;

  void selectPaymentMethod(PaymentMethod paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    // UI rule: card form should never show for cash.
    if (paymentMethod != PaymentMethod.creditCard) {
      showCardForm = false;
    }
    notifyListeners();
  }

  bool onConfirmBookingPressed() {
    if (selectedPaymentMethod == null) return false;

    if (needsCard) {
      if (!showCardForm) {
        showCardForm = true;
        notifyListeners();
        return false;
      }

      final isValid = cardFormKey.currentState?.validate() ?? false;
      if (!isValid) return false;
    }

    return true;
  }

  @override
  void dispose() {
    pageController.dispose();
    cardNumberController.dispose();
    cardHolderNameController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }
}
