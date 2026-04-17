import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/styles_manager.dart';

class DoseCard extends StatelessWidget {
  final List<TimeOfDay?> selectedTimes;
  final Function(int) deleteDose;
  final Function(int) onPickTime;
  final VoidCallback addDose;

  const DoseCard({
    super.key,
    required this.selectedTimes,
    required this.addDose,
    required this.deleteDose,
    required this.onPickTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: List.generate(selectedTimes.length, (index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text(
                    "Dose ${index + 1}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const Spacer(),

                  GestureDetector(
                    onTap: () => onPickTime(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        selectedTimes[index] == null
                            ? "Pick time"
                            : selectedTimes[index]!.format(context),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  GestureDetector(
                    onTap: () => deleteDose(index),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),

        GestureDetector(
          onTap: addDose,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, size: 18),
                  6.horizontalSpace,
                  Text(
                    "Add Dose",
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
