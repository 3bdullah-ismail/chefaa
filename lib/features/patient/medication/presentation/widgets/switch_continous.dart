import 'package:flutter/material.dart';

class SwitchContinous extends StatelessWidget {
  final Color color;
  final AlignmentGeometry alignment;
  final Function() onTap;

  const SwitchContinous({
    super.key,
    required this.color,
    required this.alignment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 55,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: alignment,
          child: Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
