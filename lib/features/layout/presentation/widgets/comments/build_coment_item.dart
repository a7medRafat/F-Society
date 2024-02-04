import 'package:flutter/material.dart';
import '../../../../../config/style/app_colors.dart';
import '../../../data/models/comment_model.dart';

class BuildCommentItem extends StatelessWidget {
  const BuildCommentItem({super.key, required this.commentModel});

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: CircleAvatar(
              backgroundImage: NetworkImage(commentModel.profileImage!),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors().rectangle1.withOpacity(0.4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(commentModel.name!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.black)),
                        const SizedBox(width: 5),
                        Text(commentModel.date!,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.black45)),
                      ],
                    ),
                    Text(
                      commentModel.comment!,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.black
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
