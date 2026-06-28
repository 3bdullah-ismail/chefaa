import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widgets/custom_text_field.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final String? prefixIcon;
  final bool isPassword;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const LabeledTextField({
    super.key,
    required this.label,
    this.keyboardType,
    this.textInputAction,
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
          textInputAction: textInputAction,
          keyboardType: keyboardType,
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
