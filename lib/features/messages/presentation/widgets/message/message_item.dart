import 'package:flutter/material.dart';
import 'package:fsociety/config/style/app_colors.dart';
import 'package:fsociety/core/shared_preferances/cache_helper.dart';
import 'package:fsociety/features/messages/data/models/last_message_model.dart';
import 'package:fsociety/features/messages/data/models/message_model.dart';
import 'package:fsociety/features/messages/presentation/widgets/message/profile_img.dart';
import '../../../../../core/navigation/navigation.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import '../../../cubit/messages_cubit.dart';
import '../../screens/message_details.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  // final AllUsersModel model;
  final LastMsgModel model;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        /// attention ////
        di.sl<MessagesCubit>()
            .getMessages(receiverId: model.receiverId!)
            .then((value) {
          Navigation().navigateTo(
              context,
              MessageDetailScreen(
                model: model,
              ));
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: AppColors().mainColor.withOpacity(0.60),
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImage(radius: 25, img: model.image!),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors().fBlack),
                  ),
                  Text(
                    model.lastMessage!,
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
      ),
    );
  }
}
