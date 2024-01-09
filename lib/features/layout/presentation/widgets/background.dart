import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:fsociety/core/utiles/app_colors.dart';

class FeedsBackground extends StatelessWidget {
  const FeedsBackground({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: size.height * -0.25,
            left: size.height * -0.9,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: size.height,
                width: size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(152.0),
                  color: AppColors().rectangle1,
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Transform.rotate(
                    angle: math.pi / 15,
                    child: Container(
                      padding: const EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(155.0),
                        border: Border.all(width: 1.0, color: Colors.white),
                      ),
                      child: Transform.rotate(
                        angle: math.pi/0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            padding: const EdgeInsets.all(40.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(155.0),
                              border: Border.all(width: 1.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
