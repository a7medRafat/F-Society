import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import 'dart:math' as math;
import '../../../../core/utiles/app_colors.dart';
import 'package:fsociety/injuctoin_container.dart' as di;
import 'clip_img.dart';

class ProfileImgWidget extends StatelessWidget {
  const ProfileImgWidget({
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
