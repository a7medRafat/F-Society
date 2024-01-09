import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/core/utiles/loading_dialog.dart';
import 'package:fsociety/core/utiles/loading_widget.dart';
import 'package:fsociety/features/layout/presentation/widgets/posts/post_widget.dart';
import '../../../../../config/style/icons_broken.dart';
import '../../../../../core/utiles/btn_sheet.dart';
import '../../../cubit/feeds_cubit.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

class PostsList extends StatefulWidget {
  final TextEditingController commentController;

  const PostsList({super.key, required this.commentController, required this.state});

  final FeedsState state;
  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> with TickerProviderStateMixin {



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => PostWidget(
              postModel: di.sl<FeedsCubit>().posts[index],
              index: index,
              likeFun: () {
                di.sl<FeedsCubit>()
                    .checkLike(di.sl<FeedsCubit>().postId[index], index);
              },
              likeValue: di.sl<FeedsCubit>().likes[index],
              loveColor: di.sl<FeedsCubit>().colors[index] == 'red'
                  ? Colors.red
                  : Colors.white,
              commentColor: FeedsCubit.get(context).commentColors[index],
              savedColor: di.sl<FeedsCubit>().savedColors[index],
              loveIcon: di.sl<FeedsCubit>().colors[index] == 'red'
                  ? Icons.favorite
                  : IconBroken.Heart,
              commentController: widget.commentController,
              commentFun: () {
                di.sl<FeedsCubit>()
                    .getComments(postId: di.sl<FeedsCubit>().postId[index])
                    .then((value) {
                  MyBtnSheet().showBtnSheet(
                    context,
                    widget.commentController,
                    () {
                      if (widget.commentController.text.isNotEmpty) {
                        di.sl<FeedsCubit>().addComment(
                            comment: widget.commentController.text,
                            index: index,
                            postId: di.sl<FeedsCubit>().postId[index]);
                        widget.commentController.clear();
                        Navigator.pop(context);
                      }
                    },
                  );
                });
              },
              commentValue: FeedsCubit.get(context).commentsNum[index],
              savedValue: di.sl<FeedsCubit>().saved[index],
              saveIcon: di.sl<FeedsCubit>().savedColors[index] == Colors.white
                  ? IconBroken.Bookmark
                  : Icons.bookmark,
              fun3: () {
                di.sl<FeedsCubit>()
                    .checkSaved(di.sl<FeedsCubit>().postId[index], index);
              },
              commentIcon: IconBroken.Chat,
            ),
        itemCount: di.sl<FeedsCubit>().posts.length);
  }
}

