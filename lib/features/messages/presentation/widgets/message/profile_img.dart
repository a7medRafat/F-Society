import 'package:flutter/material.dart';
import 'package:fsociety/config/style/app_colors.dart';
class ProfileImage extends StatelessWidget {
  final String img;
  const ProfileImage({
    Key? key,
    required this.radius, required this.img,
  }) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1.0, color: AppColors().fBlack),
      ),
      child: CircleAvatar(
        backgroundImage:NetworkImage(img),
        radius: radius,
      ),
    );
  }
}