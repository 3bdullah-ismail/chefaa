import 'package:flutter/material.dart';

class StaffMetric extends StatelessWidget {
  final String label;
  final int value;

  const StaffMetric({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value.toString(), style: Theme.of(context).textTheme.titleLarge),
          Text(label),
        ],
      ),
    );
  }
}
