import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class MedicationErrorWidget extends StatelessWidget {
  final String rawError;
  final VoidCallback onRetry;
  final VoidCallback onSignInRedirect;

  const MedicationErrorWidget({
    super.key,
    required this.rawError,
    required this.onRetry,
    required this.onSignInRedirect,
  });

  bool _isUnauthorized(String error) {
    final lowerError = error.toLowerCase();
    return lowerError.contains('unauthorized') ||
        lowerError.contains('401') ||
        lowerError.contains('token');
  }

  String _getCustomMessage(String error) {
    if (_isUnauthorized(error)) {
      return "Your session has expired. Please sign in again to access your medications.";
    }

    final lowerError = error.toLowerCase();
    if (lowerError.contains('connection') ||
        lowerError.contains('internet') ||
        lowerError.contains('socket')) {
      return "No internet connection. Please check your network and try again.";
    } else if (lowerError.contains('timeout')) {
      return "Connection timed out. The server took too long to respond.";
    } else {
      return "Something went wrong while loading your medications. Please try again later.";
    }
  }

  IconData _getErrorIcon(String error) {
    if (_isUnauthorized(error)) {
      return Icons.lock_clock_rounded;
    }
    final lowerError = error.toLowerCase();
    if (lowerError.contains('connection') || lowerError.contains('internet')) {
      return Icons.wifi_off_rounded;
    }
    return Icons.error_outline_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final isAuthError = _isUnauthorized(rawError);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getErrorIcon(rawError),
              color: ColorManager.error.withValues(alpha: 0.8),
              size: 44.sp,
            ),
            12.verticalSpace,
            Text(
              _getCustomMessage(rawError),
              textAlign: TextAlign.center,
              style: getMediumStyle(
                color: ColorManager.darkGray,
                fontSize: 14.sp,
              ),
            ),
            16.verticalSpace,

            ElevatedButton.icon(
              onPressed: isAuthError ? onSignInRedirect : onRetry,
              icon: Icon(
                isAuthError ? Icons.login_rounded : Icons.refresh_rounded,
                size: 18.sp,
                color: Colors.white,
              ),
              label: Text(
                isAuthError ? "Go to Sign In" : "Try Again",
                style: getBoldStyle(color: Colors.white, fontSize: 13.sp),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
