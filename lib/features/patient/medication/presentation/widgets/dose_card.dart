import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class DoseCard extends StatelessWidget {
  final List<TimeOfDay?> selectedTimes;
  final Function(int) deleteDose;
  final Function(int) onPickTime;

  const DoseCard({
    super.key,
    required this.selectedTimes,
    required this.deleteDose,
    required this.onPickTime,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedTimes.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            "Select Times Per Day first",
            style: getMediumStyle(color: ColorManager.gray, fontSize: 14),
          ),
        ),
      );
    }

    return Column(
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

              10.horizontalSpace,

              GestureDetector(
                onTap: () => deleteDose(index),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(70),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.red, size: 18),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
