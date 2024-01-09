import 'package:flutter/material.dart';
import 'package:fsociety/features/layout/cubit/feeds_cubit.dart';
import 'package:fsociety/features/profile/presentation/widget/profile/gride_widget.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

class ProfileSavedWidget extends StatelessWidget {
  const ProfileSavedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (di.sl<FeedsCubit>().savedList.isEmpty)
          SizedBox(
              height: 200,
              child: Center(
                  child: Text(
                'no posts saved',
                style: Theme.of(context).textTheme.titleSmall,
              ))),
        GridWidget(
            length: di.sl<FeedsCubit>().savedList.length,
            listName: di.sl<FeedsCubit>().savedList)
      ],
    );
  }
}
