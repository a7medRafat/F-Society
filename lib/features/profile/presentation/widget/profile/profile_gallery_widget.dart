import 'package:flutter/material.dart';
import 'package:fsociety/features/layout/cubit/feeds_cubit.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

import 'gride_widget.dart';

class ProfileGalleryWidget extends StatelessWidget {
  const ProfileGalleryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (di.sl<ProfileCubit>().myPosts.isEmpty)
          SizedBox(
              height: 200,
              child: Center(
                  child: Text(
                    'No Posts',
                    style: Theme.of(context).textTheme.titleSmall,
                  ))),
         GridWidget(
             length: di.sl<ProfileCubit>().myPosts.length, listName: di.sl<ProfileCubit>().myPosts)
      ],
    );
  }
}
