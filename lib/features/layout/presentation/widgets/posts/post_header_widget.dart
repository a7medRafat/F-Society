import 'package:flutter/material.dart';
import 'package:fsociety/core/utiles/app_colors.dart';
import 'package:fsociety/core/utiles/focused_menue.dart';

class PostHeaderWidget extends StatelessWidget {
  final String name;
  final String profileImg;
  final String dateTime;
  final int index;

  const PostHeaderWidget(
      {super.key,
      required this.name,
      required this.profileImg,
      required this.dateTime,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profileImg),
              maxRadius: 16.0,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(dateTime,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors().hoursColor, fontSize: 12))
              ],
            ),
          ],
        ),
        const Spacer(),
        FocusedMenu().focused(context, index)
      ],
    );
  }
}
