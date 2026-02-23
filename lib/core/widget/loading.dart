import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

class Loading {
  static bool _isLoading = false;

  static Future<void> show(BuildContext context) async {
    _isLoading = true;
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          title: Center(
            child: CircularProgressIndicator(color: ColorManager.primary),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    if (_isLoading) {
      Navigator.pop(context);
      _isLoading = false;
    }
  }
}
