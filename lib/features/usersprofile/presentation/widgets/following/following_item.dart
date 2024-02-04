import 'package:flutter/material.dart';
import 'package:fsociety/config/style/app_colors.dart';
import 'package:fsociety/features/messages/presentation/widgets/message/profile_img.dart';
import 'package:fsociety/features/usersprofile/data/models/following_model.dart';

class FollowingItem extends StatelessWidget {
  const FollowingItem({
    Key? key,
     required this.followingModel,
  }) : super(key: key);

  final FollowingModel followingModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: AppColors().mainColor.withOpacity(0.60),
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileImage(radius: 25, img: followingModel.image!),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  followingModel.name!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors().fBlack),
                ),
                Text(
                  followingModel.bio!,
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
