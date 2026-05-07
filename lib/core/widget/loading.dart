import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

class Loading {
  static bool _isLoading = false;

  /// Shows a loading dialog safely, scheduling it after the current frame if needed.
  static Future<void> show(BuildContext context) async {
    _isLoading = true;

    // Schedule after frame to avoid "setState during build" errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.transparent,
            title: Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            ),
          );
        },
      );
    });
  }

  /// Hides the loading dialog if it's currently shown.
  static void hide(BuildContext context) {
    if (_isLoading && context.mounted) {
      Navigator.pop(context);
      _isLoading = false;
    }
  }

  /// Reset the loading state (use with caution).
  static void reset() {
    _isLoading = false;
  }
}
