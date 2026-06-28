import 'package:chefaa/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class StepperHeader extends StatelessWidget {
  final int activeStep;
  final int totalSteps;

  const StepperHeader({
    super.key,
    required this.activeStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index <= activeStep;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 5,
            decoration: BoxDecoration(
              color: isActive ? ColorManager.primary : ColorManager.gray,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }),
    );
  }
}
