import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class BackArrow extends StatelessWidget {
  final VoidCallback onTap;

  const BackArrow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p8),
          decoration: const BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: ColorManager.primary,
            size: 24,
          ),
        ),
      ),
    );
  }
}
