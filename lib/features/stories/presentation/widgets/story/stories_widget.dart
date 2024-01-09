import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/features/stories/cubit/story_cubit.dart';
import 'package:fsociety/features/stories/presentation/widgets/story/add_Story_btn.dart';
import 'package:fsociety/features/stories/presentation/widgets/story/build_story_Item.dart';
import 'package:fsociety/features/stories/presentation/widgets/story_view/story_viewer.dart';
import '../../../../../core/navigation/navigation.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

class StoriesWidget extends StatelessWidget {
  const StoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const AddStoryButton(),
          ...List.generate(
            di.sl<StoryCubit>().validStories.length,
            (index) => GestureDetector(
                onTap: () {
                  Navigation().navigateTo(
                      context,
                      StoryViewer(
                        storyModel: di.sl<StoryCubit>().validStories[index],
                      ));
                },
                child: BuildStoryItem(
                    index: index,
                    img: di.sl<StoryCubit>().validStories[index].storyImage!)),
          )
        ],
      ),
    );
  }
}
