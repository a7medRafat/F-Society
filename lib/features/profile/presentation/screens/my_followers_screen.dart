import 'package:flutter/material.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import 'package:fsociety/features/usersprofile/presentation/widgets/Followers/followers_text__widget.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import '../../../usersprofile/presentation/widgets/Followers/followers_item.dart';
import '../../../usersprofile/presentation/widgets/fbackground.dart';


class MyFollowersScreen extends StatelessWidget {
  const MyFollowersScreen({super.key});

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
                        followersModel: di.sl<ProfileCubit>().myFollowers[index],
                      ),
                      itemCount: di.sl<ProfileCubit>().myFollowers.length),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
