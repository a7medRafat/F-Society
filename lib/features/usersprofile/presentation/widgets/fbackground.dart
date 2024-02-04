import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../../../config/style/app_colors.dart';

class Fbackground extends StatelessWidget {
  const Fbackground({Key? key, required this.child}) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: 200.0,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: 465,
                width: 473,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: AppColors().line1),
                  borderRadius: BorderRadius.circular(152.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: 250.0,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: 465,
                width: 473,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: AppColors().line1),
                  borderRadius: BorderRadius.circular(152.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: 330,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: 575,
                width: 580,
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