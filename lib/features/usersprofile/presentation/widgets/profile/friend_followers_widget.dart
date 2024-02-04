import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/config/style/app_colors.dart';
import 'package:fsociety/features/usersprofile/cubit/friends_cubit.dart';
import 'package:fsociety/features/usersprofile/presentation/screens/followers_screen.dart';
import 'package:fsociety/features/usersprofile/presentation/screens/following_screen.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import '../../../../../core/navigation/navigation.dart';

class FriendFollowersWidget extends StatelessWidget {
  const FriendFollowersWidget(
      {super.key,
      required this.postValue,
      required this.followersValue,
      required this.followingValue});

  final int postValue;
  final int followersValue;
  final int followingValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            content('  Posts  ', postValue, context),
            GestureDetector(
                onTap: () =>
                    Navigation().navigateTo(context, const FollowersScreen()),
                child: content('Followers', followersValue, context)),
            GestureDetector(
                onTap: () =>
                    Navigation().navigateTo(context, const FollowingsScreen()),
                child: content('Following', followingValue, context)),
          ],
        ),
      ),
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
