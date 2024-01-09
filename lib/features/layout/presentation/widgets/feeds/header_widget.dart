import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/config/style/icons_broken.dart';
import '../../../../../core/utiles/app_colors.dart';



class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Fsociety',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          foreground: Paint()..shader = AppColors().instaGradient
        )),
        IconButton(
            onPressed: () {},
            icon: Icon(IconBroken.Notification,color: Colors.black,))
      ],
    );
  }
}
