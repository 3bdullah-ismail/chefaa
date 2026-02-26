import 'package:flutter/services.dart';

class LicenseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll('-', '').toUpperCase();

    if (text.length > 9) {
      text = text.substring(0, 9);
    }

    String letters = '';
    String numbers = '';

    for (int i = 0; i < text.length; i++) {
      if (i < 3) {
        if (RegExp(r'[A-Z]').hasMatch(text[i])) {
          letters += text[i];
        }
      } else {
        if (RegExp(r'[0-9]').hasMatch(text[i])) {
          numbers += text[i];
        }
      }
    }

    String formatted = letters;

    if (numbers.isNotEmpty) {
      formatted += '-';
    }

    if (numbers.length <= 3) {
      formatted += numbers;
    } else {
      formatted += '${numbers.substring(0, 3)}-${numbers.substring(3)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
