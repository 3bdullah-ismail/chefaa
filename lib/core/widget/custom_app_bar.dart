import 'package:flutter/material.dart';
import '../resources/color_manager.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: ColorManager.primary,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 50),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "assets/images/chefaa.png",
              height: 70,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
    );
  }
}
