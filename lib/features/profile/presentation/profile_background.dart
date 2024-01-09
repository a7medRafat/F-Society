import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/utiles/app_colors.dart';

class ProfileBackground extends StatelessWidget {
  const ProfileBackground({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -50,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: size.height * 0.65,
                width: size.height * 0.65,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: AppColors().line1),
                  borderRadius: BorderRadius.circular(152.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: -90,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: size.height * 0.65,
                width: size.height * 0.65,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: AppColors().line1),
                  borderRadius: BorderRadius.circular(152.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: -130,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: size.height * 0.65,
                width: size.height * 0.65,
                decoration: BoxDecoration(
                  color: AppColors().rectangle1,
                  borderRadius: BorderRadius.circular(152.0),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
