import 'package:flutter/material.dart';

class FacilityLayout extends StatelessWidget {
  const FacilityLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Facility Layout'), centerTitle: true),
      body: const Center(child: Text('Facility layout is ready')),
    );
  }
}
