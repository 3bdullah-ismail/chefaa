
import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: getBoldStyle(color: ColorManager.darkGray, fontSize: 16.sp),
    );
  }
}
