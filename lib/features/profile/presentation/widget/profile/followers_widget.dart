import 'package:flutter/material.dart';
import 'package:fsociety/core/utiles/app_colors.dart';
import 'package:fsociety/features/layout/cubit/feeds_cubit.dart';
import 'package:fsociety/injuctoin_container.dart' as di;


class FollowersWidget extends StatelessWidget {

   const FollowersWidget({super.key});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            content('Posts', di.sl<FeedsCubit>().myPosts.length,context),
            content('Likes', 12,context),
            content('saved', di.sl<FeedsCubit>().savedList.length,context),
          ],
        ),
      ),
    );
  }


  Widget content(String title, int value , context)=>Column(
    children: [
      Text(
        title,
        style:Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppColors().captionColor,

        ),
      ),
      Text(
        value.toString(),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 20
        ),
      ),
    ],
  );
}