import 'package:flutter/material.dart';
import 'package:fsociety/features/layout/cubit/feeds_cubit.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

import 'gride_widget.dart';

class ProfileGalleryWidget extends StatelessWidget {
  const ProfileGalleryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (di.sl<FeedsCubit>().myPosts.isEmpty)
          SizedBox(
              height: 200,
              child: Center(
                  child: Text(
                    'no posts',
                    style: Theme.of(context).textTheme.titleSmall,
                  ))),
         GridWidget(length: di.sl<FeedsCubit>().myPosts.length, listName: di.sl<FeedsCubit>().myPosts)
      ],
    );
  }
}
