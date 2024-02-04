import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:fsociety/config/style/app_colors.dart';

class Background extends StatelessWidget {
  const Background({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScaffoldMessenger(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: size.height * -0.3,
              left: size.height * -0.6,
              child: Transform.rotate(
                angle: math.pi / 4,
                child: Container(
                  height: size.height,
                  width: size.height,
                  padding: const EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(155.0),
                    border: Border.all(width: 1.0, color: AppColors().line1),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(152.0),
                      color: AppColors().rectangle1,
                    ),
                  ),
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
