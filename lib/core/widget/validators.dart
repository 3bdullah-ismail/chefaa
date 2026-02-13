import 'package:email_validator/email_validator.dart';

class Validators {
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) return 'Name cannot be empty';

    final RegExp nameRegExp = RegExp(r"^[\p{L}\s\-]+$", unicode: true);
    if (!nameRegExp.hasMatch(value)) {
      return 'Enter a valid name (letters, spaces, and hyphens only)';
    }
    if (value.length < 2) return 'Name must be at least 2 characters long';
    if (value.length > 50) return 'Name cannot exceed 50 characters';
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

    if (!usernameRegex.hasMatch(value)) {
      return 'Use only letters, numbers, and underscores (3-20 chars)';
    }

    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Email cannot be empty.';
    if (!EmailValidator.validate(email)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone cannot be empty.';
    }

    if (phone.length >= 10) {
      return null;
    } else {
      return "Enter a valid phone";
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter password';

    final regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$',
    );
    if (!regex.hasMatch(value)) {
      return 'Password must be at least 8 chars\n and contain upper, lower,\n number & special char';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != password) return 'Passwords do not match';
    return null;
  }

  static String? validateMedicalLicense(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Medical license number is required';
    }
    final formatted = value.trim().toUpperCase();

    final regex =
    RegExp(r'^(ALP|LIC)-\d{2,3}-\d{2,3}$');

    if (!regex.hasMatch(formatted)) {
      return 'Format must be ALP-234-896 or LIC-67-78';
    }

    return null;
  }

}
