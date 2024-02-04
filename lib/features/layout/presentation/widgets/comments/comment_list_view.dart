import 'package:flutter/cupertino.dart';
import 'package:fsociety/features/layout/presentation/widgets/comments/build_coment_item.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import '../../../cubit/feeds_cubit.dart';

class CommentListView extends StatelessWidget {
  const CommentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => BuildCommentItem(
              commentModel: di.sl<FeedsCubit>().comments[index],
            ),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: di.sl<FeedsCubit>().comments.length);
  }
}
