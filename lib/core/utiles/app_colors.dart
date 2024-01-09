import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  Color rectangle1 = Color(0xFFE1F6F4);
  Color rectangle2 = Color(0xFF4E4E4E);
  Color rectangle3 = Color(0xFFC4C4C4);
  Color mainColor = Colors.white;
  Color secondaryColor = Colors.white;
  Color captionColor = Color(0xFF656565);
  Color rectangle4 = Colors.black;
  Color fBlack = Colors.black;
  Color hoursColor = Color(0xFFD8D8D8);
  Color line1 = Color(0xFFEEF2E2);
  Color hintColor = Color(0xFF4E4E4E);
  Color k3Pink = Color(0xFFF5C8C6);
  Color storyBorder = Color(0xFF25A0B0);
  Color fSelectedTapCol = Color(0xFF7DB9B3);
  Color appErrorColor = Color(0xFFee6b70);
  Color appSuccessColor = Color(0xFF90f184);
  Color appVerifyColor = Color(0XFFffff9e).withOpacity(0.6);

  RadialGradient grediant = RadialGradient(
      center: Alignment.topCenter,
      radius: 0.8,
      colors: [Color(0xffffe1e0), Color(0xffE1F6F4)]);

  Shader instaGradient = LinearGradient(
          colors: [Color(0xffF9CE34), Color(0xffee2a7b), Color(0xff6228d7)])
      .createShader(Rect.fromLTWH(0.0, 0.0, 200, 70.0));
}
