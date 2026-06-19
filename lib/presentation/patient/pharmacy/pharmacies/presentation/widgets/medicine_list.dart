import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../medicines/data/models/medicine_model.dart';
import '../../../medicines/presentation/pages/medicine_details_page.dart';
import '../../../medicines/presentation/widgets/medicine_card.dart';


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
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MedicineDetailsPage(
                  name: med.name,
                  activeIngredient: med.activeIngredient,
                  price: med.price,
                ),
              ),
            );
          },
          child: MedicineCard(
            name: med.name,
            description: med.activeIngredient,
            price: med.price,
            onAddTap: () {

            },
          ),
        );
      },
    );
  }
}