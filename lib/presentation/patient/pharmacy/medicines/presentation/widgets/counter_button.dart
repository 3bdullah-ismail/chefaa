import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isEnabled;
  final IconData icon;

  const CounterButton({
    super.key,
    required this.icon,
    required this.isEnabled,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: const Color(0xff0F172A).withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Icon(
          icon,
          size: 16,
          color: isEnabled ? const Color(0xff0F172A) : const Color(0xff94A3B8),
        ),
      ),
    );
  }
}
