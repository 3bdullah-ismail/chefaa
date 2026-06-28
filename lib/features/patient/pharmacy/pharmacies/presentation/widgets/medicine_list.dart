import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/features/patient/pharmacy/medicines/data/models/medicine_model.dart';
import 'package:chefaa/features/patient/pharmacy/medicines/presentation/pages/medicine_details_page.dart';
import 'package:chefaa/features/patient/pharmacy/medicines/presentation/widgets/medicine_card.dart';
import 'package:chefaa/features/patient/cart/presentation/manager/cart_cubit.dart';

class MedicineList extends StatelessWidget {
  final List<MedicineModel> medicines;
  const MedicineList({super.key, required this.medicines});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: medicines.length,
      separatorBuilder: (_, _) => 16.verticalSpace,
      itemBuilder: (_, index) {
        final med = medicines[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MedicineDetailsPage(
                  name: med.name,
                  activeIngredient: med.category,
                  price: '${med.price} EGP',
                  medicineId: med.id,
                ),
              ),
            );
          },
          child: MedicineCard(
            name: med.name,
            description: med.category,
            price: '${med.price} EGP',
            onAddTap: () {
              CartManager().addToCart(
                pharmacyId: '6a0a13efd785cd1a6461b64c', // Fallback pharmacy ID
                medicineId: med.id,
                name: med.name,
                dosage: med.category,
                price: med.price.toDouble(),
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
                          '1 Pack of ${med.name} added to cart.',
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
        );
      },
    );
  }
}
