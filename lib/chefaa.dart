
import 'package:chefaa/core/imports/imports.dart';
import 'core/routes/routes.dart';
import 'core/theme/app_theme.dart';

class Chefaa extends StatelessWidget {
  const Chefaa({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
