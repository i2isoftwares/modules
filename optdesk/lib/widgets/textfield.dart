import 'package:flutter/material.dart';
import 'package:optdesk/helpers/colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.placeholder,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding,
    this.maxLines,
    this.squareInput = true,
    this.readOnly = false,
    this.controller,
    this.obscureText = false,
    this.fillColor,
    this.onChanged,
    this.keyboardType,
    this.maxLength,
    this.textInputAction,
    this.onSubmitted,
  });

  final Function(String)? onChanged;
  final Function? onSubmitted;
  final bool squareInput;
  final bool readOnly;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final String placeholder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      readOnly: this.readOnly,
      maxLines: this.maxLines ?? 1,
      obscureText: this.obscureText,
      onChanged: this.onChanged,
      keyboardType: this.keyboardType,
      maxLength: this.maxLength,
      textInputAction: this.textInputAction ?? TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: orange),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: fillColor,
        hintText: placeholder,
        hintStyle: TextStyle(color: grey),
        contentPadding: contentPadding,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}

//For CovidQAForm
class CustomTextField1 extends StatelessWidget {
  CustomTextField1({
    Key? key,
    @required this.placeholder,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding,
    this.maxLines,
    this.squareInput = true,
    this.readOnly = false,
    this.controller,
    this.obscureText = false,
    this.fillColor,
    this.onChanged,
    this.keyboardType,
    this.maxLength,
    this.textInputAction,
    this.onSubmitted,
    this.validator
  });

  final Function(String)? onChanged;
  final Function? onSubmitted;
  final Function? validator;
  final bool squareInput;
  final bool readOnly;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final String? placeholder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      readOnly: this.readOnly,
      maxLines: this.maxLines ?? 1,
      obscureText: this.obscureText,
      onChanged: this.onChanged,
      keyboardType: this.keyboardType,
      maxLength: this.maxLength,
      textInputAction: this.textInputAction ?? TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: orange),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        fillColor: fillColor ?? Colors.transparent,
        hintText: placeholder,
        hintStyle: TextStyle(color: grey),
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}