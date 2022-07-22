import 'package:flutter/material.dart';
import 'package:tatsam/Utils/constants/colors.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      cursorColor: whiteColor,
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
        prefix: Text(prefix),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: style,
    );
  }
}
