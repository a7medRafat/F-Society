import 'package:flutter/material.dart';
import 'package:fsociety/core/utiles/app_colors.dart';
import 'package:fsociety/features/messages/data/models/get_all_users.dart';
import 'package:fsociety/features/messages/presentation/widgets/profile_img.dart';

import '../../../../core/navigation/navigation.dart';
import '../../cubit/messages_cubit.dart';
import '../screens/message_details.dart';

GetAllUsersModel? model;

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    required this.message,
    required this.model,
  }) : super(key: key);

  final GetAllUsersModel model;
  final String message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MessagesCubit.get(context).getMessages(receiverId: model.uid!);
        Future.delayed(const Duration(seconds: 2));
          Navigation().navigateTo(context, MessageDetailScreen( model: model));
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: AppColors().mainColor.withOpacity(0.60),
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileImage(radius: 25, img: model.image!),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors().fBlack),
                  ),
                  Text(
                    message,
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
