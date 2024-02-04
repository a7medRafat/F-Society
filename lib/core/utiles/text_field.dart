import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/config/style/app_colors.dart';
import 'package:fsociety/core/utiles/sizes.dart';

class DefaultField extends StatelessWidget {
  final controller;
  final String hint;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final String? suffixText;
  final Widget? suffixIconBtn;
  final Widget? suffixTextBtn;
  final Color? suffixIconColor;
  final Color? filledColor;
  final bool isPassword;
  TextInputType textInputType;
  final suffixPressed;
  final validation;
  final onChanged;
  bool? borderSide = true;
  bool? filled = false;


  DefaultField({
    super.key,
    required this.controller,
    required this.hint,
    required this.isPassword,
    required this.textInputType,
    required this.validation,
    this.suffixPressed,
    this.suffixIcon,
    this.suffixText,
    this.suffixIconColor,
    this.prefixIcon,
    this.suffixIconBtn,
    this.suffixTextBtn,
    this.filled,
    this.filledColor,
    this.onChanged,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        onChanged:onChanged,
        keyboardType: textInputType,
        validator: validation,
        obscureText: isPassword,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: AppColors().hintColor),
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: borderSide == false ?  BorderSide.none : BorderSide(

            ),
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: IconButton(
              onPressed: suffixPressed,
              icon: Icon(suffixIcon, color: suffixIconColor)),
          suffixText: suffixText,
          hintText: hint,
          hintStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: AppColors().hintColor),
          filled: filled,
          fillColor: filledColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors().rectangle1,
              width: AppSizes().borderWidth,
            ),
          ),
        ),
      ),
    );
  }
}
