import 'package:flutter/material.dart';

import '../pages/choose_visit_type.dart';

class BookingProvider extends ChangeNotifier {
  int activeStep = 0;

  final PageController pageController = PageController();

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
}
