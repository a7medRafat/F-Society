import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/features/layout/presentation/widgets/comments/comment_button_sheet.dart';
import 'package:fsociety/features/layout/presentation/widgets/posts/post_widget.dart';
import '../../../../../config/style/icons_broken.dart';
import '../../../cubit/feeds_cubit.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

class PostsList extends StatelessWidget {
  PostsList({super.key, required this.state});

  TextEditingController commentController = TextEditingController();
  final FeedsState state;

  final Stream<QuerySnapshot> postsStream =
  FirebaseFirestore.instance.collection('posts').snapshots();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return PostWidget(
            postModel: di.sl<FeedsCubit>().posts[index],
            index: index,
            likeFun: () {
              di.sl<FeedsCubit>().checkLike(di.sl<FeedsCubit>().postId[index], index);
            },
            likeValue: di
                .sl<FeedsCubit>()
                .likes[index],
            loveColor: di
                .sl<FeedsCubit>()
                .colors[index] == 'red'
                ? Colors.red
                : Colors.white,
            commentColor: FeedsCubit
                .get(context)
                .commentColors[index],
            savedColor: di
                .sl<FeedsCubit>()
                .savedColors[index],
            loveIcon: di
                .sl<FeedsCubit>()
                .colors[index] == 'red'
                ? Icons.favorite
                : IconBroken.Heart,
            commentFun: () {
              di.sl<FeedsCubit>().getComments(postId: di
                  .sl<FeedsCubit>()
                  .postId[index])
                  .then((value) {
                CommentButtonSheet().view(
                    controller: commentController,
                    context: context,
                    sendCommentFun: () {
                      if (commentController.text.isNotEmpty) {
                        di.sl<FeedsCubit>().addComment(
                            comment: commentController.text,
                            postId: di
                                .sl<FeedsCubit>()
                                .postId[index],
                            index: index);
                      }
                      Navigator.pop(context);
                    });
              });
            },
            commentValue: FeedsCubit
                .get(context)
                .commentsNum[index],
            savedValue: di
                .sl<FeedsCubit>()
                .saved[index],
            saveIcon:
            di
                .sl<FeedsCubit>()
                .savedColors[index] == Colors.white
                ? IconBroken.Bookmark
                : Icons.bookmark,
            fun3: () {
              di.sl<FeedsCubit>().checkSaved(di
                  .sl<FeedsCubit>()
                  .postId[index], index);
            },
            commentIcon: IconBroken.Chat,
            state: state,
            friendsModel: di
                .sl<FeedsCubit>()
                .posts[index],
          );
        },

        itemCount: di.sl<FeedsCubit>().posts.length
      // di.sl<FeedsCubit>().posts.length
    );
  }
}
