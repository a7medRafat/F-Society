import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/utiles/loading_widget.dart';
import 'package:fsociety/features/usersprofile/cubit/friends_cubit.dart';
import '../../../../../core/utiles/app_button.dart';
import 'gallery_text.dart';

class FollowAndGalleryWidget extends StatelessWidget {
  FollowAndGalleryWidget({super.key, required this.sendFollow});

  final Function() sendFollow;
  bool followORNot = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const GalleryTextWidget(),
          Expanded(
              child: BlocConsumer<FriendsCubit, FriendsState>(
            listener: (BuildContext context, FriendsState state) {},
            builder: (context, state) {
              if (state is CheckIsFollowLoadingState) {
                return const LoadingWidget();
              }
              return FriendsCubit.get(context).iFollowThisUser
                  ? AppButton(
                      text: 'following', fun: sendFollow, btnColor: Colors.grey.withOpacity(0.8))
                  : AppButton(
                      text: 'follow',
                      fun: sendFollow,
                      btnColor: Colors.blueAccent);
            },
          ))
        ],
      ),
    );
  }
}
