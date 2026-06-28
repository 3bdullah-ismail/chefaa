import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentCardForm extends StatelessWidget {
  const PaymentCardForm({
    super.key,
    required this.formKey,
    required this.cardNumberController,
    required this.cardHolderNameController,
    required this.expiryDateController,
    required this.cvvController,
    this.borderColor = ColorManager.input,
    this.borderWidth = 1,
    this.removeTopBorder = false,
    this.showShadow = true,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderNameController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;

  final Color borderColor;
  final double borderWidth;
  final bool removeTopBorder;
  final bool showShadow;

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return null;
  }

  bool _isValidLuhn(String number) {
    int sum = 0;
    bool alternate = false;

    for (int i = number.length - 1; i >= 0; i--) {
      int n = int.parse(number[i]);

      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }

      sum += n;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  String? _validateCardNumber(String? value) {
    final requiredError = _required(value);
    if (requiredError != null) return requiredError;

    final digits = value!.replaceAll(RegExp(r'\s+'), '');

    if (!RegExp(r'^\d{16}$').hasMatch(digits)) {
      return 'Card number must be 16 digits';
    }

    if (!_isValidLuhn(digits)) {
      return 'Invalid card number';
    }

    return null;
  }

  String? _validateExpiry(String? value) {
    final requiredError = _required(value);
    if (requiredError != null) return requiredError;

    if (!RegExp(r'^(0[1-9]|1[0-2])/\d{2}$').hasMatch(value!.trim())) {
      return 'Use MM/YY';
    }

    return null;
  }

  String? _validateCvv(String? value) {
    final requiredError = _required(value);
    if (requiredError != null) return requiredError;

    if (!RegExp(r'^\d{3,4}$').hasMatch(value!.trim())) {
      return 'Enter a valid CVV';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        border: removeTopBorder
            ? Border(
                left: BorderSide(color: borderColor, width: borderWidth),
                right: BorderSide(color: borderColor, width: borderWidth),
                bottom: BorderSide(color: borderColor, width: borderWidth),
                top: BorderSide.none,
              )
            : Border.all(color: borderColor, width: borderWidth),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xA8CBE3D3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Secure payment - Your data is encrypted",
                style: TextStyle(color: Color(0xFF34A853), fontSize: 13),
              ),
            ),
            const SizedBox(height: 16),

            const Text("Card Number"),
            const SizedBox(height: 6),
            CustomTextField(
              controller: cardNumberController,
              text: "e.g., •••• •••• •••• 4242",
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(19),
              ],
              validator: _validateCardNumber,
            ),

            const SizedBox(height: 12),

            const Text("Cardholder Name"),
            const SizedBox(height: 6),
            CustomTextField(
              controller: cardHolderNameController,
              text: "e.g., Khaled Mohamed",
              textInputAction: TextInputAction.next,
              validator: _required,
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Expiry Date"),
                      const SizedBox(height: 6),
                      CustomTextField(
                        controller: expiryDateController,
                        text: "MM/YY",
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(5)],
                        validator: _validateExpiry,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("CVV"),
                      const SizedBox(height: 6),
                      CustomTextField(
                        controller: cvvController,
                        text: "e.g., 123",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        validator: _validateCvv,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
