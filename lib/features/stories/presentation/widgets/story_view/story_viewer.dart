import 'package:flutter/material.dart';
import 'package:fsociety/core/utiles/linear_progress.dart';
import 'package:fsociety/features/stories/data/models/story_model.dart';
import 'package:fsociety/features/stories/presentation/widgets/story_view/story_view_header_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import '../../../cubit/story_cubit.dart';

class StoryViewer extends StatelessWidget {
  final StoryModel storyModel;

  const StoryViewer({super.key, required this.storyModel});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.topLeft,
          children: [
            PhotoViewGallery.builder(
              itemCount: di.sl<StoryCubit>().validStories.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(storyModel.storyImage!),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained,
                  heroAttributes: const PhotoViewHeroAttributes(tag: 2),
                );
              },
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              pageController: PageController(viewportFraction: 2),
            ),
            StoryViewHeaderWidget(storyModel: storyModel),
            const LinearProgressWidget()
          ],
        ));
  }
}


