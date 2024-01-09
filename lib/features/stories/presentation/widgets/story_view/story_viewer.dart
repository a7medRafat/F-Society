import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/core/utiles/linear_progress.dart';
import 'package:fsociety/features/stories/data/models/story_model.dart';
import 'package:fsociety/features/stories/presentation/widgets/story_view/story_view_header_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:fsociety/injuctoin_container.dart' as di;
import '../../../cubit/story_cubit.dart';

class StoryViewer extends StatefulWidget {
  final StoryModel storyModel;

  const StoryViewer({super.key, required this.storyModel});

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  double _progressValue = 0.0;

  void _startLoading() {
    const duration = Duration(seconds: 5);
    Timer.periodic(
        Duration(milliseconds: (duration.inMilliseconds / 100).round()),
        (timer) {
      setState(() {
        if (_progressValue < 1.0) {
          _progressValue += 0.01;
        } else {
          timer.cancel();
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
              imageProvider: NetworkImage(widget.storyModel.storyImage!),
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
        StoryViewHeaderWidget(storyModel: widget.storyModel),
        LinearProgressWidget(fun: () => Navigator.pop(context))
      ],
    ));
  }
}
