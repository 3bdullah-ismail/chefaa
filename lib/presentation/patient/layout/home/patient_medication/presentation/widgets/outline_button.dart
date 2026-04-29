import 'package:flutter/material.dart';
import '../../../../../../../core/resources/styles_manager.dart';
import '../../../../../../../core/resources/values_manager.dart';

class OutlineButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final Color color;
  final bool isEditSheet;

  const OutlineButton({
    super.key,
    this.isEditSheet = false,
    required this.onPressed,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding:  EdgeInsets.symmetric(
          horizontal: isEditSheet?AppPadding.p100: AppPadding.p16,
          vertical:isEditSheet?AppPadding.p14: AppPadding.p2,
        ),
        minimumSize: Size.zero,
        side:  BorderSide(color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(
        title,
        style: getRegularStyle(
          color: color,
          fontSize: 16,
        )
      ),
    );
  }
}
