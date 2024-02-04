import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../../../config/style/app_colors.dart';
import '../../../../profile/presentation/widget/clip_img.dart';


class UsersProfileImgWidget extends StatelessWidget {
  const UsersProfileImgWidget({
    super.key, required this.img,
  });

  final ImageProvider img;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height / 15),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: 140.0,
              height: 140.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: AppColors().fBlack),
                borderRadius: BorderRadius.circular(35.0),
              ),
            ),
          ),
          ClipPath(
              clipper: ProfileImageClipper(),
              child: Image(
                image: img,
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ))
        ],
      ),
    );
  }
}
