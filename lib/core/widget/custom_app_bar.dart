import 'package:flutter/material.dart';
import '../resources/color_manager.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: ColorManager.primary,
      shadowColor: ColorManager.black.withValues(alpha: .25),
      elevation: 15,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 50),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "assets/images/chefaa.png",
              height: 70,
              fit: BoxFit.fill,
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
