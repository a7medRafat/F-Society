import 'package:flutter/cupertino.dart';
import 'package:fsociety/features/layout/presentation/widgets/comments/build_comment_header.dart';
import 'package:fsociety/features/layout/presentation/widgets/comments/build_comment_input.dart';
import '../../../../../core/utiles/my_button_sheet.dart';
import 'comment_list_view.dart';

class CommentButtonSheet {
  Future<void> view(
          {context,
          required TextEditingController controller,
          required Function() sendCommentFun}) =>
      MyButtonSheet().showButtonSheet(
          context,
          Column(
            children: [
              const CommentHeader(),
              const CommentListView(),
              CommentInput(
                  controller: controller, sendCommentFun: sendCommentFun)
            ],
          ));
}
