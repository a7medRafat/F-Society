import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/navigation/navigation.dart';
import 'package:fsociety/features/layout/presentation/screens/App_Layout.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import '../../cubit/story_cubit.dart';
import '../../../layout/presentation/widgets/background.dart';
import '../widgets/story_view/add_story_header_widget.dart';
import '../widgets/story_view/share_story_btn.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FeedsBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocConsumer<StoryCubit, StoryState>(
          listener: (context, state) {
            if (state is CreateStoryImgSuccessState) {
             Navigation().navigateAndFinish(context, const AppLayout());
            }
          },
          builder: (context, state) {
            return Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(di.sl<StoryCubit>().storyImg!),
                          fit: BoxFit.cover)),
                ),
                const AddStoryHeaderWidget(),
                  ShareStoryBtn(),
              ],
            );
          },
        ),
      ),
    );
  }
}
