import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeTextFormField extends StatelessWidget {
  final String? hintText;
  final TextInputType? keyboradType;
  final Widget? prefixIcon;
  final Color? hintcolors;
  final Color? fillColor;
  final Color? enabledColor;
  final Color? disabledColor;
  final Color? borderColor;
  final Color? focusedColor;
  final bool? obscureText;
  final String? initialValues;
  final Widget? sufixIcon;
  final int? maxline;
  final int? maxlength;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  final TextEditingController? textEditingController;
  const CustomeTextFormField({
    super.key,
    this.hintText,
    this.keyboradType,
    this.prefixIcon,
    this.hintcolors,
    this.fillColor,
    this.enabledColor,
    this.disabledColor,
    this.borderColor,
    this.focusedColor,
    this.obscureText,
    this.textEditingController,
    this.initialValues,
    this.sufixIcon,
    this.onChanged,
    this.maxline,
    this.maxlength,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key("CustomeTextFormField"),
      validator: validator,
      maxLines: maxline,
      maxLength: maxlength,
      onChanged: onChanged,
      initialValue: initialValues,
      controller: textEditingController,
      keyboardType: keyboradType,
      style: const TextStyle(color: Colors.black),
      autocorrect: true,
      obscureText: obscureText!,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: "",
        hintStyle: GoogleFonts.poppins(color: hintcolors, fontSize: 14, fontWeight: FontWeight.w400),
        filled: true,
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: borderColor!,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: enabledColor!,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: focusedColor!,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: sufixIcon,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: disabledColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
