import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class ServicesSearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onSearchPressed;

  const ServicesSearchBarWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onSearchPressed,
  });

  @override
  State<ServicesSearchBarWidget> createState() =>
      _ServicesSearchBarWidgetState();
}

class _ServicesSearchBarWidgetState extends State<ServicesSearchBarWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorManager.input.withValues(alpha: 0.8),
          width: 1.w,
        ),
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Search services, codes, or department",
          hintStyle: getRegularStyle(color: ColorManager.gray, fontSize: 13.sp),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: ColorManager.gray,
            size: 20.sp,
          ),
          suffixIcon: widget.controller.text.trim().isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.search_rounded,
                    color: ColorManager.primary,
                  ),
                  onPressed: widget.onSearchPressed,
                )
              : null,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }
}
