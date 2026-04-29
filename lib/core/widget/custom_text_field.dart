import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

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

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  // We'll debounce visual updates caused by frequent onChanged events to
  // avoid excessive setState calls that can contribute to jank during typing.
  Timer? _debounce;

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

    // Debounced listener to reduce rebuilds while user types.
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    // short debounce to update UI (error icon color etc.) without rebuilding on every keystroke
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      setState(() {});
    });
  }

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Widget _buildPrefixIcon() {
    // Determine current error state synchronously from validator to avoid
    // scheduling post-frame callbacks in the validator which cause many
    // redundant rebuilds.
    final currentError = widget.validator?.call(widget.controller.text);
    if (currentError != null) {
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
      return IconButton(
        onPressed: widget.onPressSearch,
        icon: Padding(
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
      readOnly: widget.isReadOnly,
      focusNode: _focusNode,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _isObscure,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // Keep validator pure and synchronous. We perform visual updates using
      // the debounced controller listener above instead of scheduling
      // post-frame callbacks from inside the validator.
      validator: widget.validator,
      onTapOutside: (_) => _focusNode.unfocus(),
      style: widget.completeData
          ? getMediumStyle(color: ColorManager.gray, fontSize: 16)
          : getRegularStyle(color: ColorManager.black, fontSize: 16),
       decoration: InputDecoration(
         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
         enabledBorder: widget.isSearch
             ? OutlineInputBorder(
                 borderRadius: BorderRadius.circular(25),
                 borderSide: const BorderSide(color: ColorManager.gray),
               )
             : OutlineInputBorder(
                 borderRadius: BorderRadius.circular(8),
                 borderSide: const BorderSide(color: ColorManager.gray, width: 1),
               ),
         focusedBorder: widget.isSearch
             ? OutlineInputBorder(
                 borderRadius: BorderRadius.circular(25),
                 borderSide: const BorderSide(color: ColorManager.primary),
               )
             : OutlineInputBorder(
                 borderRadius: BorderRadius.circular(8),
                 borderSide: const BorderSide(color: ColorManager.primary, width: 2),
               ),
         errorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(8),
           borderSide: const BorderSide(color: ColorManager.error, width: 1),
         ),
         focusedErrorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(8),
           borderSide: const BorderSide(color: ColorManager.error, width: 2),
         ),
         suffixText: widget.suffixText,
         suffixStyle: getMediumStyle(color: ColorManager.gray, fontSize: 16),
         hintText: widget.text,
         hintStyle: getRegularStyle(color: ColorManager.gray, fontSize: 16),
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
             : widget.rec
             ? IconButton(
                 icon: const Icon(
                   Icons.mic_none_outlined,
                   color: ColorManager.primary,
                   size: 32,
                 ),
                 onPressed: () {
                   widget.onPressMic!();
                 },
               )
             : null,
       ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.controller.removeListener(_onTextChanged);
    _focusNode.dispose();
    super.dispose();
  }
}
