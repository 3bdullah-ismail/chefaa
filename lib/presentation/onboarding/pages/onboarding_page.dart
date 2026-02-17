import 'package:flutter/material.dart';

import '../models/onboarding_model.dart';
import '../widgets/onboarding_container.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const ScrollPhysics(),
              controller: controller,
              itemBuilder: (context, index) => Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      OnboardingModel.onboardingData[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: OnboardingContainer(
                      next: nextPage,
                      screenIndex: index,
                      onboarding: OnboardingModel.onboardingData,
                    ),
                  ),
                ],
              ),
              itemCount: OnboardingModel.onboardingData.length,
            ),
          ),
        ],
      ),
    );
  }

  void nextPage() {
    if (currentIndex < OnboardingModel.onboardingData.length - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
