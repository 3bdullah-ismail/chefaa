import 'package:flutter/material.dart';
import '../../../../../../core/resources/color_manager.dart';
import 'dosage_metric_item.dart';
import 'indication_chip.dart';

class UsageInstructionsMatrix extends StatelessWidget {
  const UsageInstructionsMatrix({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const DosageMetricItem(
                title: "Standard Dose",
                value: "1–2 Tablets",
                icon: Icons.medication_rounded,
                bg: Color(0xffEFF6FF),
                iconColor: ColorManager.primary,
              ),

              _buildVerticalDivider(),

              const DosageMetricItem(
                title: "Interval Cycle",
                value: "Every 4–6 hrs",
                icon: Icons.history_toggle_off_rounded,
                bg: Color(0xffF0FDF4),
                iconColor: Color(0xff16A34A),
              ),

              _buildVerticalDivider(),

              const DosageMetricItem(
                title: "24H Limit",
                value: "Max 8 Tabs",
                icon: Icons.gpp_maybe_rounded,
                bg: Color(0xffFFF1F2),
                iconColor: Color(0xffE11D48),
              ),
            ],
          ),

          const SizedBox(height: 18),
          const Divider(height: 1, color: Color(0xffF1F5F9)),
          const SizedBox(height: 14),

          const Text(
            "CLINICAL INDICATIONS & TARGETS",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xff94A3B8),
            ),
          ),

          const SizedBox(height: 10),

          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              IndicationChip(
                text: "Mild to Moderate Pain Relief",
                icon: Icons.healing_rounded,
              ),
              IndicationChip(
                text: "Fever Reduction",
                icon: Icons.thermostat_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 80, color: const Color(0xffF1F5F9));
  }
}
