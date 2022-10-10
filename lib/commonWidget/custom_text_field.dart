import 'package:flutter/material.dart';
import 'package:tatsam/Utils/constants/colors.dart';
import 'package:tatsam/Utils/constants/textStyle.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final ValueChanged<String>? onChange;
  final TextStyle? style;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final int maxLength;
  final String prefix;
  final bool isBorder;
  final String hintText;
  final bool enabled;
  final Color cursorColor;
  final bool obscureText;
  final bool isObscureText;
  final VoidCallback? onObscureTap;

  // ignore: use_key_in_widget_constructors
  const CustomTextField({
    this.onChange,
    this.controller,
    this.style,
    this.textInputType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.validator,
    this.maxLength = 255,
    this.prefix = '',
    this.isBorder = true,
    this.hintText = '',
    this.enabled = true,
    this.cursorColor = whiteColor,
    this.obscureText = false,
    this.isObscureText = false,
    this.onObscureTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: textInputType,
      autocorrect: false,
      cursorColor: cursorColor,
      controller: controller,
      maxLength: maxLength,
      focusNode: focusNode,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction ?? TextInputAction.next,
      onChanged: onChange,
      buildCounter: (BuildContext context,
              {int? currentLength, int? maxLength, bool? isFocused}) =>
          null,
      decoration: InputDecoration(
        prefix: Text(prefix, style: style),
        hintText: hintText,
        hintStyle: size12Regular(textColor: hintTextColor),
        enabledBorder: isBorder
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              )
            : InputBorder.none,
        focusedBorder: isBorder
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              )
            : InputBorder.none,
        border: isBorder
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              )
            : InputBorder.none,
        suffixIcon: isObscureText
            ? GestureDetector(
                onTap: onObscureTap,
                child: obscureText
                    ? const Icon(Icons.visibility_off,
                        color: whiteColor, size: 18)
                    : const Icon(Icons.visibility, color: whiteColor, size: 18),
              )
            : null,
      ),
      style: style,
    );
  }
}
