import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/core/utiles/text_field.dart';
import '../../features/layout/cubit/feeds_cubit.dart';
import '../../features/layout/data/models/comment_model.dart';
import 'app_colors.dart';

class MyBtnSheet {
  Color iconColor = Colors.grey;

  void showBtnSheet(context, TextEditingController controller, final fun) =>
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 20,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        btnSheetHeader(context),
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => buildCommentItem(
                                FeedsCubit.get(context).comments[index],
                                context,
                                fun),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                            itemCount: FeedsCubit.get(context).comments.length),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: DefaultField(
                              onChanged: (value) {
                                if (controller.text.isEmpty) {
                                  iconColor = Colors.grey;
                                } else {
                                  iconColor = Colors.deepPurple;
                                }
                              },
                              borderSide: false,
                              controller: controller,
                              hint: 'write a comment',
                              isPassword: false,
                              suffixIcon: Icons.arrow_forward,
                              suffixIconColor: iconColor,
                              suffixPressed: fun,
                              filled: true,
                              filledColor: const Color(0xffefefef).withOpacity(0.4),
                              textInputType: TextInputType.text,
                              validation: (value) {
                                if (value.isEmpty) {
                                  return 'required';
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });

  Widget buildCommentItem(
    CommentModel commentModel,
    context,
    final fun,
  ) =>
      Padding(
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
                          SizedBox(width: 5),
                          Text(commentModel.date!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.black45)),
                        ],
                      ),
                      Text(
                        commentModel.comment!,
                        style: Theme.of(context).textTheme.titleSmall,
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

  Widget btnSheetHeader(context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                Container(
                  height: 5,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColors().rectangle3,
                  ),
                ),
                Container(
                  height: 2,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
          Text('comments',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors().rectangle2)),
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              height: 0.2,
              color: Colors.grey.withOpacity(0.3),
              width: double.infinity,
            ),
          ),
        ],
      );
}
