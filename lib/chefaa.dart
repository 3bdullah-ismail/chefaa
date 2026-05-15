import 'package:chefaa/core/extensions/build_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes/app_routes_names.dart';
import 'core/routes/routes.dart';
import 'core/theme/app_theme.dart';

class Chefaa extends StatelessWidget {
  const Chefaa({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(context.width, context.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.generateRoute,
        initialRoute: AppRoutesNames.login,
        );
      },
    );
  }
}
