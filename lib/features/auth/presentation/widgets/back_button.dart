import 'package:chefaa/core/imports/imports.dart';
import 'package:chefaa/core/resources/color_manager.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            CupertinoIcons.left_chevron,
            size: 30,
            color: ColorManager.black,
          ),
        ),
      ],
    );
  }
}
