import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? trailing;

  const SectionTitle({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: getBoldStyle(color: ColorManager.black, fontSize: 15.sp),
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: getRegularStyle(
              color: ColorManager.darkGray,
              fontSize: 12.sp,
            ),
          ),
      ],
    );
  }
}
