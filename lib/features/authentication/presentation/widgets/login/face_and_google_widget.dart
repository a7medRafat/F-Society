import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/features/authentication/cubit/login_cubit/login_cubit.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

class FaceAndGoogleWidget extends StatelessWidget {
  const FaceAndGoogleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildItem(
            icon: BootstrapIcons.google,
            iconSize: 20,
            fun: () => di.sl<LoginCubit>().googleSignIn(), backColor: Colors.redAccent),
        const SizedBox(width: 20),
        buildItem(icon: BootstrapIcons.facebook, iconSize: 22, fun: () =>di.sl<LoginCubit>().facebookSignIn(), backColor: Colors.blue),
      ],
    );
  }

  buildItem(
          {required IconData icon,
          required double iconSize,
          required Function() fun ,
          required backColor}) =>
      Container(
          decoration: BoxDecoration(
              color: backColor, borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: IconButton(
                  onPressed: fun,
                  icon: Icon(icon, color: Colors.white, size: iconSize))));
}
