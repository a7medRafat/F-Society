import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/features/stories/data/models/story_model.dart';
import '../../../../../core/const/const.dart';
import 'package:intl/intl.dart';

class StoryViewHeaderWidget extends StatelessWidget {

  final StoryModel storyModel;

  const StoryViewHeaderWidget({
    super.key, required this.storyModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(storyModel.image!),
                radius: 20,
              ),
              SizedBox(width: 15),
              Text(
                storyModel.name!,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              ),
              SizedBox(width: 15),
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
