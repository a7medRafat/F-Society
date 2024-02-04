import 'package:flutter/material.dart';
import 'package:fsociety/config/style/app_colors.dart';
import 'package:fsociety/features/messages/presentation/widgets/message/profile_img.dart';

import '../../../data/models/followers_model.dart';

class FollowersItem extends StatelessWidget {
  const FollowersItem({
    Key? key,
    required this.followersModel,
  }) : super(key: key);

  final FollowersModel followersModel;

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
          ProfileImage(radius: 25, img: followersModel.image!),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  followersModel.name!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors().fBlack),
                ),
                Text(
                  followersModel.bio!,
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
