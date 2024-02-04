import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/local_storage/hive_keys.dart';
import 'package:fsociety/core/local_storage/user_storage.dart';
import 'package:fsociety/core/navigation/navigation.dart';
import 'package:fsociety/core/utiles/app_bar.dart';
import 'package:fsociety/core/utiles/loading_widget.dart';
import 'package:fsociety/core/utiles/toggle.dart';
import 'package:fsociety/features/profile/presentation/screens/edit_profile.dart';
import 'package:fsociety/features/profile/presentation/widget/profile/followers_widget.dart';
import '../../cubit/profile_cubit.dart';
import '../profile_background.dart';
import '../widget/profile/name_bio_widget.dart';
import '../widget/profile_img_widget.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    di.sl<ProfileCubit>().getMydData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            if(state is GetMyDataLoadingState){
              return const LoadingWidget();
            }
            return CustomScrollView(
              slivers: [
                MyAppBar().sliverBar(
                    context: context,
                    actionText: 'Edit profile',
                    textColor: Colors.deepPurple,
                    actionFun: () =>
                        Navigation().navigateTo(context, EditProfileScreen()),
                    height: 0.65,
                    backGround: ProfileBackground(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ProfileImgWidget(
                                    img: di.sl<ProfileCubit>().profileImg == null
                                        ? NetworkImage(di.sl<UserStorage>()
                                        .getData(id: HiveKeys.currentUser)!.image!)
                                        : FileImage(
                                        di.sl<ProfileCubit>().profileImg!)
                                    as ImageProvider,
                                  ),
                                  const NameAndBioWidget(),
                                ],
                              ),
                            ),
                            const FollowersWidget(),
                          ],
                        ),
                      ),
                    )),
                SliverList(delegate: SliverChildListDelegate([const Toggle()]))
              ],
            );
          },
        ),
      ),
    );
  }
}
