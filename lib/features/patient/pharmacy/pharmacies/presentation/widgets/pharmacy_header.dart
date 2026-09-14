import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class PharmacyHeader extends StatelessWidget {
  final String title;

  const PharmacyHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorManager.black,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'View All',
            style: getMediumStyle(color: ColorManager.primary, fontSize: 16.sp)
                .copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: ColorManager.primary,
                  decorationThickness: 2,
                ),
          ),
        ),
      ],
    );
  }
}
