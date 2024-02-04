import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/utiles/loading_widget.dart';
import 'package:fsociety/features/stories/cubit/story_cubit.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

class ShareStoryBtn extends StatefulWidget {
   ShareStoryBtn({
    super.key,
  });

  @override
  State<ShareStoryBtn> createState() => _ShareStoryBtnState();
}

class _ShareStoryBtnState extends State<ShareStoryBtn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 10,
        right: 5,
        child: BlocConsumer<StoryCubit, StoryState>(
          listener: (context, state) {},
          builder: (context, state) {
            return GestureDetector(
                onTap: () {
                  di.sl<StoryCubit>().uploadStoryImg();
                  setState(() {
                    isLoading = true;
                  });
                },
                child:isLoading == true ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LoadingWidget(),
                )
                    :  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, right: 20, left: 20),
                      child: Text('Share',
                          style: Theme.of(context).textTheme.bodySmall),
                    )));
          },
        ));
  }
}
