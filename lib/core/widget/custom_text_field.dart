import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    required this.text,
    this.isPass = false,
    this.keyboardType,
    this.prefixIcon,
    this.completeData = false,
    this.suffixText = "",
    this.inputFormatters,
    this.textInputAction ,
  });

  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String text;
  final bool isPass;
  final TextInputType? keyboardType;
  final String? prefixIcon;
  final bool completeData;
  final String? suffixText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;


  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscure;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPass;

    _focusNode.addListener(() {
      if (!mounted) return;
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Widget _buildPrefixIcon() {
    if (_errorText != null) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: SvgPicture.asset(
          widget.prefixIcon!,
          width: 22,
          height: 22,
          colorFilter: const ColorFilter.mode(
            ColorManager.error,
            BlendMode.srcIn,
          ),
        ),
      );
    }
    if (_isFocused) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: SvgPicture.asset(
          widget.prefixIcon!,
          width: 22,
          height: 22,
          colorFilter: const ColorFilter.mode(
            ColorManager.primary,
            BlendMode.srcIn,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SvgPicture.asset(
        widget.prefixIcon!,
        width: 22,
        height: 22,
        colorFilter: const ColorFilter.mode(ColorManager.gray, BlendMode.srcIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _isObscure,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        final result = widget.validator?.call(value);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          setState(() {
            _errorText = result;
          });
        });
        return result;
      },
      onTapOutside: (_) => _focusNode.unfocus(),
      style: widget.completeData
          ? getMediumStyle(color: ColorManager.gray, fontSize: 16)
          : getRegularStyle(color: ColorManager.black, fontSize: 16),
      decoration: InputDecoration(
        suffixText: widget.suffixText,
        suffixStyle: getMediumStyle(color: ColorManager.gray, fontSize: 16),
        hintText: widget.text,
        prefixIcon: widget.prefixIcon != null
            ? AnimatedBuilder(
                animation: _focusNode,
                builder: (context, _) {
                  return _buildPrefixIcon();
                },
              )
            : null,

        suffixIcon: widget.isPass
            ? IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: ColorManager.gray,
                ),
                onPressed: _toggleObscure,
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
