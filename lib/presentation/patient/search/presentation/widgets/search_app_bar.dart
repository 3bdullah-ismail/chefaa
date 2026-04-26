import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const SearchAppBar({super.key, this.title});

  @override
  Size get preferredSize => Size.fromHeight(110.h);

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.canPop(context);
    return AppBar(
      backgroundColor: ColorManager.input.withValues(alpha: 50),
      shadowColor: ColorManager.transparent,
      elevation: 15,
      automaticallyImplyLeading: false,
      leading: canPop
          ? Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: ColorManager.black,
                    size: 20.sp,
                  ),
                ),
              ),
            )
          : null,
      centerTitle: true,
      title: Text(
        title ?? "",
        style: getBoldStyle(color: ColorManager.black, fontSize: 26.sp),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
    );
  }
}
