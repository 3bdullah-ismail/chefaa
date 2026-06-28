import 'package:flutter/material.dart';

class RiskLevel {
  final String title;
  final String description;
  final IconData icon;

  const RiskLevel({
    required this.title,
    required this.description,
    required this.icon,
  });

  static RiskLevel fromScore(double score) {
    if (score <= 3.3) {
      return const RiskLevel(
        title: "Normal",
        description:
            "Your health is stable with no risk detected.\nKeep your healthy lifestyle and routine.",
        icon: Icons.check_circle,
      );
    } else if (score <= 6.6) {
      return const RiskLevel(
        title: "Low Risk",
        description:
            "Mild risk detected and needs attention.\nImprove habits and monitor your health regularly.",
        icon: Icons.warning_amber_rounded,
      );
    } else {
      return const RiskLevel(
        title: "High Risk",
        description:
            "High risk detected and requires action.\nConsult a doctor as soon as possible.",
        icon: Icons.dangerous,
      );
    }
  }
}
