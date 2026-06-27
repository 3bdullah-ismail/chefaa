import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/medicine_model.dart';
import 'package:chefaa/presentation/patient/cart/presentation/manager/cart_manager.dart';
import 'add_to_cart_button.dart';

class HorizontalMedicineCard extends StatelessWidget {
  final MedicineModel medicine;
  final String pharmacyId;

  const HorizontalMedicineCard({
    super.key,
    required this.medicine,
    required this.pharmacyId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            medicine.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: Color(0xff1A1D29),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            medicine.category,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${medicine.price} EGP',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff0F8A5F),
                ),
              ),
              AddToCartButton(
                onPressed: () {
                  CartManager().addToCart(
                    pharmacyId: pharmacyId,
                    medicineId: medicine.id,
                    name: medicine.name,
                    dosage: medicine.category,
                    price: medicine.price.toDouble(),
                    quantity: 1,
                  );
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '1 Pack of ${medicine.name} added to cart.',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: const Color(0xff059669),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
