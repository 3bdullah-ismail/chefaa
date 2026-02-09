import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    required this.text,
    this.isPass = false,
    this.keyboardType,
    this.prefixIcon,
    this.activeIcon,
  });

  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String text;
  final bool isPass;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? activeIcon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscure;

  final FocusNode _focusNode = FocusNode(); // ✅ FIX
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
      return const Padding(
        padding: EdgeInsets.all(12),
        child: Icon(Icons.error, color: Colors.red),
      );
    }
    if (_isFocused) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: widget.activeIcon,
      );
    }
    return Padding(padding: const EdgeInsets.all(12), child: widget.prefixIcon);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _isObscure,
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
      style: getRegularStyle(color: ColorManager.gray, fontSize: 16),
      decoration: InputDecoration(
        hintText: widget.text,
        prefixIcon: AnimatedBuilder(
          animation: _focusNode,
          builder: (context, _) {
            return _buildPrefixIcon();
          },
        ),

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
