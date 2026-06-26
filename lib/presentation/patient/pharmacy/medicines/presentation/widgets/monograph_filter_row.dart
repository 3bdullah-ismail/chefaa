import 'package:flutter/material.dart';
import '../../../../../../core/resources/color_manager.dart';

class MonographFilterRow extends StatelessWidget {
  final String selectedSection;
  final ValueChanged<String> onChanged;

  const MonographFilterRow({
    super.key,
    required this.selectedSection,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final sections = ["Overview", "Clinical Actions", "Safety & Risks"];

    return Row(
      children: sections.map((section) {
        final isSelected = selectedSection == section;

        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(section),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? ColorManager.primary : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? ColorManager.primary
                      : const Color(0xffE2E8F0),
                ),
              ),
              child: Text(
                section,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : const Color(0xff64748B),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
