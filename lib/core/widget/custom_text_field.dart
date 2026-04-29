import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum _TextFieldVisualState { empty, valid, error }

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    required this.text,
    this.onChanged,
    this.isPass = false,
    this.keyboardType,
    this.prefixIcon,
    this.completeData = false,
    this.suffixText = "",
    this.inputFormatters,
    this.textInputAction,
    this.rec = false,
    this.onPressMic,
    this.onPressSearch,
    this.isReadOnly = false,
    this.isSearch = false,
  });

  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String text;
  final bool isPass;
  final bool isReadOnly;
  final TextInputType? keyboardType;
  final String? prefixIcon;
  final bool completeData;
  final bool rec;
  final String? suffixText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final void Function()? onPressMic;
  final void Function()? onPressSearch;
  final bool isSearch;
  final Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPass;
  }

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  _TextFieldVisualState _resolveState(String value) {
    if (value.trim().isEmpty) {
      return _TextFieldVisualState.empty;
    }
    final errorMessage = widget.validator?.call(value);
    return errorMessage == null
        ? _TextFieldVisualState.valid
        : _TextFieldVisualState.error;
  }

  Color _resolveColor(_TextFieldVisualState state) {
    switch (state) {
      case _TextFieldVisualState.empty:
        return ColorManager.gray.withValues(alpha: 0.5);
      case _TextFieldVisualState.valid:
        return ColorManager.primary;
      case _TextFieldVisualState.error:
        return ColorManager.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: widget.controller,
      builder: (context, value, _) {
        final visualState = _resolveState(value.text);
        final currentColor = _resolveColor(visualState);
        final theme = Theme.of(context);
        final decorationTheme = theme.inputDecorationTheme;
        final borderRadius = BorderRadius.circular(24.r);
        final isError = visualState == _TextFieldVisualState.error;

        return TextFormField(
          readOnly: widget.isReadOnly,
          textInputAction: widget.textInputAction,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: _isObscure,
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          style: getRegularStyle(color: ColorManager.black, fontSize: 16),
          decoration: InputDecoration(
            filled: decorationTheme.filled,
            fillColor: decorationTheme.fillColor ?? ColorManager.lightGray,
            contentPadding: decorationTheme.contentPadding ??
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            hintText: widget.text,
            hintStyle:
                decorationTheme.hintStyle ??
                getSemiBoldStyle(color: ColorManager.gray, fontSize: 16),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SvgPicture.asset(
                      widget.prefixIcon!,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        currentColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 50,
              minHeight: 0,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: currentColor,
                width: isError ? 1.5 : 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: currentColor,
                width: isError ? 1.5 : 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(
                color: ColorManager.error,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(
                color: ColorManager.error,
                width: 1.5,
              ),
            ),
            errorStyle: const TextStyle(height: 0, fontSize: 0),
            suffixText: widget.suffixText,
            suffixStyle:
                getSemiBoldStyle(color: ColorManager.gray, fontSize: 16),
            suffixIcon: widget.isPass
                ? IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: ColorManager.gray,
                    ),
                    onPressed: _toggleObscure,
                  )
                : widget.rec
                ? IconButton(
                    icon: const Icon(
                      Icons.mic_none_outlined,
                      color: ColorManager.primary,
                      size: 28,
                    ),
                    onPressed: widget.onPressMic,
                  )
                : null,
          ),
        );
      },
    );
  }
}
