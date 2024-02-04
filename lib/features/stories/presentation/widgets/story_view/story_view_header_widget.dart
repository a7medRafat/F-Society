import 'package:flutter/material.dart';
import 'package:fsociety/features/stories/data/models/story_model.dart';
import 'package:intl/intl.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

import '../../../../../core/local_storage/hive_keys.dart';
import '../../../../../core/local_storage/user_storage.dart';

class StoryViewHeaderWidget extends StatelessWidget {

  final StoryModel storyModel;

  const StoryViewHeaderWidget({
    super.key, required this.storyModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(storyModel.image!),
                radius: 20,
              ),
              const SizedBox(width: 15),
              Text(
                storyModel.name!,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(width: 15),
              // TimeAgoWidget(timestamp: FeedsCubit.get(context).validStories[index].date!),
              Text(DateFormat('kk:mm:a').format(DateTime.parse(storyModel.date!)).toString()

                ,style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black38,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 15,
                    ),
                  )))
        ],
      ),
    );
  }
}
