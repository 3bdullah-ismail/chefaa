import 'package:flutter/material.dart';

class EmptyMedicineState extends StatelessWidget {
  const EmptyMedicineState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(Icons.inventory_2_outlined, size: 64),

        SizedBox(height: 16),

        Text("No match found"),

        SizedBox(height: 6),

        Text("Try looking up alternative active compounds"),
      ],
    );
  }
}
