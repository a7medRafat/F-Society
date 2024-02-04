import 'package:flutter/material.dart';
import 'package:fsociety/config/style/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    fontFamily: 'Poppins',
    iconTheme: IconThemeData(color: Colors.black, size: 22),
    textTheme: TextTheme(
      titleLarge: (TextStyle(
        fontSize: 39,
        fontWeight: FontWeight.w700,
        color: AppColors().fBlack,
      )),
      bodyLarge: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        color: AppColors().mainColor,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      titleSmall: TextStyle(
        color: AppColors().fBlack,
        fontSize: 13,
        fontWeight: FontWeight.w300,
      ),

    ),
  );
}
