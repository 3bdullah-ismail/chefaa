import 'package:flutter/material.dart';
import 'package:chefaa/presentation/pharmacy/profile/data/models/pharmacy_profile_response.dart';

class ProfileStatsBar extends StatelessWidget {
  final PharmacyStats? stats;
  const ProfileStatsBar({super.key, this.stats});

  @override
  Widget build(BuildContext context) {
    if (stats == null) return const SizedBox();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            Icons.local_pharmacy_outlined,
            stats?.totalMedicines?.toString() ?? "0",
            "Total Medicines",
            Colors.blue,
          ),
          Container(width: 1, height: 40, color: Colors.grey.shade200),
          _buildStatItem(
            context,
            Icons.shopping_bag_outlined,
            stats?.totalOrders?.toString() ?? "0",
            "Total Orders",
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
