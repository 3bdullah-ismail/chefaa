import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/widget/custom_text_field.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final String? prefixIcon;
  final bool isPassword;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.isPassword = false,
    this.validator,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getMediumStyle(color: ColorManager.black, fontSize: 16),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          key: ValueKey(label),
          inputFormatters: inputFormatters,
          validator: validator,
          controller: controller,
          text: hint,
          prefixIcon: prefixIcon,
          isPass: isPassword,
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}