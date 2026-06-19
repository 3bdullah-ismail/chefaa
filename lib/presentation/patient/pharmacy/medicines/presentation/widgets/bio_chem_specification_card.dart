import 'package:flutter/material.dart';
import 'specification_row.dart';

class BioChemSpecificationCard extends StatelessWidget {
  const BioChemSpecificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xffF1F5F9),
        ),
      ),
      child: const Column(
        children: [
          SpecificationRow(
            label: "ATC Classification",
            value: "N02BE01 / J01CA04",
            icon: Icons.fingerprint_rounded,
          ),

          Divider(
            height: 24,
            color: Color(0xffF1F5F9),
          ),

          SpecificationRow(
            label: "Absolute Bioavailability",
            value: "85% – 90% Intestinal absorption",
            icon: Icons.blur_on_rounded,
          ),

          Divider(
            height: 24,
            color: Color(0xffF1F5F9),
          ),

          SpecificationRow(
            label: "Plasma Half-Life Curve",
            value: "1.5 – 3.0 Hours baseline clearance",
            icon: Icons.hourglass_empty_rounded,
          ),

          Divider(
            height: 24,
            color: Color(0xffF1F5F9),
          ),

          SpecificationRow(
            label: "Excretion Pathway",
            value: "Hepatic metabolism / Renal filter",
            icon: Icons.gavel_rounded,
          ),
        ],
      ),
    );
  }
}