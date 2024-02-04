import 'package:flutter/material.dart';
import 'package:fsociety/features/usersprofile/cubit/friends_cubit.dart';
import 'package:fsociety/features/usersprofile/presentation/widgets/Followers/followers_text__widget.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

import '../widgets/Followers/followers_item.dart';
import '../widgets/fbackground.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Fbackground(
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
                  const FollowersTextWidget(),
                  const SizedBox(height: 30),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => FollowersItem(
                            followersModel:
                                di.sl<FriendsCubit>().friendFollowers[index],
                          ),
                      itemCount: di.sl<FriendsCubit>().friendFollowers.length),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
