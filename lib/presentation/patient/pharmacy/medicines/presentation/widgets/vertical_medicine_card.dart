import 'package:flutter/material.dart';

import '../../data/models/medicine_model.dart';
import '../pages/medicine_details_page.dart';
import 'add_to_cart_button.dart';

class VerticalMedicineCard extends StatelessWidget {
  final MedicineModel medicine;

  const VerticalMedicineCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MedicineDetailsPage(
              name: medicine.name,
              activeIngredient: medicine.activeIngredient,
              price: medicine.price,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xffEAF7F0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.medication_outlined,
                color: Color(0xff0F8A5F),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff1A1D29),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    medicine.activeIngredient,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    medicine.price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff0F8A5F),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            AddToCartButton(medicineName: medicine.name),
          ],
        ),
      ),
    );
  }
}
