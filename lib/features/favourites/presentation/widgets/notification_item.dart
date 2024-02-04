import 'package:flutter/material.dart';
import 'package:fsociety/config/style/app_colors.dart';
import 'package:fsociety/core/navigation/navigation.dart';
import 'package:fsociety/features/addpost/data/models/post_model.dart';
import 'package:fsociety/features/layout/presentation/screens/App_Layout.dart';
import 'package:fsociety/features/messages/presentation/widgets/message/profile_img.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import 'package:fsociety/features/favourites/data/models/notification_model.dart';
import 'package:fsociety/features/usersprofile/presentation/screens/friend_profile.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    required this.model,
    required this.notificationModel,
  }) : super(key: key);

  final NotificationModel notificationModel;
  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        notificationModel.body == 'started following you'
            ? Navigation().navigateTo(
                context,
                FriendProfile(friendsModel: model,))
            : Navigation().navigateTo(context, const AppLayout());
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: notificationModel.body == 'started following you'
              ? const Color(0xfffd5c63).withOpacity(0.15)
              : AppColors().mainColor.withOpacity(0.60),
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImage(radius: 25, img: notificationModel.image!),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notificationModel.title!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors().fBlack),
                  ),
                  Text(
                    notificationModel.body!,
                    style: Theme.of(context)
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
      ),
    );
  }
}
