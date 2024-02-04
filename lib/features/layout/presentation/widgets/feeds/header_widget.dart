import 'package:flutter/material.dart';
import 'package:fsociety/config/style/icons_broken.dart';
import '../../../../../config/style/app_colors.dart';
import '../../../../../core/local_storage/hive_keys.dart';
import '../../../../../core/local_storage/user_storage.dart';
import '../../../../../core/navigation/navigation.dart';
import '../../../../../core/shared_preferances/cache_helper.dart';
import '../../../../../core/utiles/dialog.dart';
import '../../../../authentication/cubit/login_cubit/login_cubit.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

import '../../../../authentication/presentation/screens/login_screen/login_screen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Fsociety',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                foreground: Paint()..shader = AppColors().instaGradient)),
        IconButton(
            onPressed: () {
              MyDialog().show(context, () {
                di.sl<LoginCubit>().signOut().then((value) {
                  CacheHelper.removeData(key: 'uid');
                  CacheHelper.removeData(key: 'DEVICE_TOKEN');
                  di.sl<UserStorage>().deleteData(id: HiveKeys.currentUser);
                  Navigation().navigateTo(context, LoginScreen());
                });
              });
            },
            icon: const Icon(
              IconBroken.Logout,
              color: Colors.black,
            )),
      ],
    );
  }
}
