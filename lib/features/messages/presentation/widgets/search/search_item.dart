import 'package:flutter/material.dart';
import 'package:fsociety/config/style/app_colors.dart';
import 'package:fsociety/core/navigation/navigation.dart';
import 'package:fsociety/features/messages/data/models/get_all_users.dart';
import 'package:fsociety/features/messages/presentation/widgets/message/profile_img.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

import '../../../cubit/messages_cubit.dart';
import '../../screens/search_message_details.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key? key,
    required this.model,
  }) : super(key: key);


  final AllUsersModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        di.sl<MessagesCubit>()
            .getMessages(receiverId: model.uid!)
            .then((value) {
          Navigation().navigateTo(context, SearchMessageDetailScreen(model: model));
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
                    model.bio!,
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
