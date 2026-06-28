import 'package:flutter/material.dart';
import 'package:chefaa/core/resources/color_manager.dart';

class HeroBanner extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onCart;

  const HeroBanner({super.key, required this.onBack, required this.onCart});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorManager.primary.withValues(alpha: 0.07),
                const Color(0xffF1F5F9),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.vaccines_rounded,
                color: ColorManager.primary,
                size: 50,
              ),
            ),
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 16,
          child: _CircularIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: onBack,
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 16,
          child: _CircularIconButton(
            icon: Icons.shopping_cart_sharp,
            onTap: onCart,
          ),
        ),
      ],
    );
  }
}

class _CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircularIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, size: 25, color: ColorManager.primary),
        onPressed: onTap,
      ),
    );
  }
}
