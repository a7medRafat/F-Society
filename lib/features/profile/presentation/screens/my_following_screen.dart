import 'package:flutter/material.dart';
import 'package:fsociety/features/messages/presentation/widgets/message/messsages_background.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import 'package:fsociety/features/usersprofile/cubit/friends_cubit.dart';
import 'package:fsociety/features/usersprofile/presentation/widgets/following/following_item.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

import '../../../usersprofile/presentation/widgets/following/following_text_widget.dart';


class MyFollowingsScreen extends StatelessWidget {
  const MyFollowingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MessageBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FollowingTextWidget(),
                  const SizedBox(height: 30),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => FollowingItem(
                        followingModel: di.sl<ProfileCubit>().myFollowing[index],
                      ),
                      itemCount: di.sl<ProfileCubit>().myFollowing.length),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
