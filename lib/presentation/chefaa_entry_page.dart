import 'package:flutter/material.dart';

import '../core/resources/color_manager.dart';
import '../core/resources/constants_manager.dart';
import '../core/routes/app_routes_names.dart';
import '../core/services/share_service.dart';
import '../core/services/storage_service.dart';

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
    final token = await StorageService.getToken();
    final user = await StorageService.getUser();
    final isFirst = await SharedServices.getBool("isFirst");

    if (isFirst ?? true) {
      await SharedServices.saveBool("isFirst", false);
      Navigator.pushReplacementNamed(context, AppRoutesNames.onboardingRoute);
    }

    if (token == null || user == null) {
      Navigator.pushReplacementNamed(context, AppRoutesNames.login);
      return;
    }

    final route = AppConstants.getLayoutFromRole(user.role);
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
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
