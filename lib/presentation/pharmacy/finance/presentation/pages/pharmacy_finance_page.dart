import 'package:flutter/material.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class PharmacyFinancePage extends StatelessWidget {
  const PharmacyFinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      appBar: AppBar(
        title: Text(
          'Pharmacy Finance',
          style: getBoldStyle(color: ColorManager.black, fontSize: 20),
        ),
        backgroundColor: ColorManager.white,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Welcome to Pharmacy Finance Page',
          style: getMediumStyle(color: ColorManager.darkGray, fontSize: 16),
        ),
      ),
    );
  }
}
