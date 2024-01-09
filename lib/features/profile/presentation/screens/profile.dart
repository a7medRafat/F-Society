import 'package:flutter/material.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/core/navigation/navigation.dart';
import 'package:fsociety/core/utiles/app_bar.dart';
import 'package:fsociety/core/utiles/toggle.dart';
import 'package:fsociety/features/profile/presentation/screens/edit_profile.dart';
import 'package:fsociety/features/profile/presentation/widget/profile/followers_widget.dart';
import '../../cubit/profile_cubit.dart';
import '../profile_background.dart';
import '../widget/profile/name_bio_widget.dart';
import '../widget/profile_img_widget.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileBackground(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: MyAppBar().appBar(
          text: 'Edit Profile',
          context: context,
          fun: () => Navigation().navigateTo(context, EditProfileScreen())),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ProfileImgWidget(
                img: di.sl<ProfileCubit>().profileImg == null
                    ? NetworkImage(di
                        .sl<UserStorage>()
                        .getData(id: HiveKeys.currentUser)!
                        .image!)
                    : FileImage(di.sl<ProfileCubit>().profileImg!)
                        as ImageProvider,
              ),
              const NameAndBioWidget(),
              const FollowersWidget(),
              const Toggle()
            ],
          ),
        ),
      ),
    ));
  }
}
