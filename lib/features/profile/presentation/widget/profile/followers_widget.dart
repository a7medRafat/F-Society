import 'package:flutter/material.dart';
import 'package:fsociety/config/style/app_colors.dart';
import 'package:fsociety/features/layout/cubit/feeds_cubit.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import 'package:fsociety/features/profile/presentation/screens/my_followers_screen.dart';
import 'package:fsociety/features/profile/presentation/screens/my_following_screen.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

import '../../../../../core/navigation/navigation.dart';

class FollowersWidget extends StatelessWidget {
  const FollowersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        content('  Posts  ', di.sl<ProfileCubit>().myPosts.length, context),
        GestureDetector(
            onTap: () =>
                Navigation().navigateTo(context, const MyFollowersScreen()),
            child: content('Followers',
                di.sl<ProfileCubit>().myFollowers.length, context)),
        GestureDetector(
            onTap: () =>
                Navigation().navigateTo(context, const MyFollowingsScreen()),
            child: content('Following',
                di.sl<ProfileCubit>().myFollowing.length, context)),
      ],
    );
  }

  Widget content(String title, int value, context) => Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors().captionColor,
                ),
          ),
          Text(
            value.toString(),
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
          ),
        ],
      );
}
