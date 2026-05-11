import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../core/resources/color_manager.dart';
import '../core/resources/constants_manager.dart';
import '../core/routes/app_routes_names.dart';
import '../core/services/permissions_service.dart';
import '../core/services/storage_service.dart';
import '../core/widget/permissions_request_dialog.dart';

class ChefaaEntryPage extends StatefulWidget {
  const ChefaaEntryPage({super.key});

  @override
  State<ChefaaEntryPage> createState() => _ChefaaEntryPageState();
}

class _ChefaaEntryPageState extends State<ChefaaEntryPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    if (!mounted) return;

    final hasSeenOnboarding = await StorageService.hasSeenOnboarding();

    if (!hasSeenOnboarding) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutesNames.onboardingRoute);
      return;
    }

    final token = await StorageService.getToken();
    final user = await StorageService.getUser();

    if (token == null || user == null) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutesNames.login);
      return;
    }
    if (!mounted) return;
    await _requestPermissionsIfNeeded();

    if (!mounted) return;
    final route = AppConstants.getLayoutFromRole(user.role);
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }

  Future<void> _requestPermissionsIfNeeded() async {
    final allPermissionsGranted =
        await PermissionsService.areCriticalPermissionsGranted();

    if (allPermissionsGranted) {
      return;
    }

    if (!mounted) return;

    final result = await showDialog<Map<String, PermissionStatus>>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PermissionsRequestDialog(),
    );

    if (result != null && mounted) {
      debugPrint('Permissions requested: $result');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: ColorManager.primary),
      ),
    );
  }
}
