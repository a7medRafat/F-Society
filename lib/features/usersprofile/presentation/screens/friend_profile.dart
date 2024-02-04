import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/shared_preferances/cache_helper.dart';
import 'package:fsociety/core/utiles/app_bar.dart';
import 'package:fsociety/core/utiles/loading_widget.dart';
import 'package:fsociety/features/addpost/data/models/post_model.dart';
import 'package:fsociety/features/usersprofile/cubit/friends_cubit.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import '../../../profile/presentation/profile_background.dart';
import '../widgets/profile/follow_gallery_widget.dart';
import '../widgets/profile/friend_followers_widget.dart';
import '../widgets/profile/friends_bio_name_widget.dart';
import '../widgets/profile/users_gallery_widget.dart';
import '../widgets/profile/users_profile_widget.dart';


class FriendProfile extends StatefulWidget {
  const FriendProfile({super.key, required this.friendsModel});

  final PostModel friendsModel;

  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  @override
  void initState() {
    setState(() {
      di.sl<FriendsCubit>().getFriendData(friendUid: widget.friendsModel.uid!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> followersStream = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.friendsModel.uid)
        .collection('followers')
        .snapshots();

    return Scaffold(
      body: BlocConsumer<FriendsCubit, FriendsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetFriendDataLoadingState) {
            return const LoadingWidget();
          }
          return CustomScrollView(
            slivers: [
              MyAppBar().sliverBar(
                  context: context,
                  height: 0.65,
                  backGround: ProfileBackground(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 9),
                          UsersProfileImgWidget(
                              img: NetworkImage(widget.friendsModel.image!)),
                          FriendsNameAndBioWidget(
                            name: widget.friendsModel.name!,
                            bio: widget.friendsModel.bio!,
                          ),
                          const Spacer(),
                          StreamBuilder(
                            stream: followersStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const LoadingWidget();
                              }
                              return FriendFollowersWidget(
                                  postValue: FriendsCubit.get(context)
                                      .friendGalley
                                      .length,
                                  followersValue: snapshot.data.docs.length,
                                  followingValue: FriendsCubit.get(context)
                                      .friendFollowing
                                      .length);
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      if (widget.friendsModel.uid !=
                          CacheHelper.getData(key: 'uid'))
                        FollowAndGalleryWidget(
                            sendFollow: () {
                          FriendsCubit.get(context).checkFriendFollow(
                            receiverUid: widget.friendsModel.uid!,
                            receiverName: widget.friendsModel.name!,
                            receiverImg: widget.friendsModel.image!,
                            receiverBio: widget.friendsModel.bio!,
                            token: widget.friendsModel.deviceToken!,
                          );
                        }),
                      UsersProfileGalleryWidget(
                        length: FriendsCubit.get(context).friendGalley.length,
                        gallery: FriendsCubit.get(context).friendGalley,
                      ),
                    ],
                  ),
                ),
              ]))
            ],
          );
        },
      ),
    );
  }
}
