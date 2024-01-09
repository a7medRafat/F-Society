import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/config/style/icons_broken.dart';
import 'package:fsociety/features/addpost/data/models/post_model.dart';
import 'package:fsociety/features/layout/presentation/widgets/posts/post_footer_widget.dart';
import 'package:fsociety/features/layout/presentation/widgets/posts/post_header_widget.dart';

class PostWidget extends StatelessWidget {
  final PostModel postModel;
  final int index;
  final int likeValue;
  final int commentValue;
  final int savedValue;
  final Function likeFun;
  final Color loveColor;
  final IconData loveIcon;
  final IconData saveIcon;
  final IconData commentIcon;
  final Color commentColor;
  final Color savedColor;
  final TextEditingController commentController;
  final fun;
  final commentFun;
  final fun3;




  const PostWidget(
      {super.key,
      required this.postModel,
      required this.loveColor,
      required this.commentColor,
      required this.savedColor,
      required this.index,
      required this.likeValue,
      required this.likeFun,
      required this.loveIcon,
      required this.commentController,
      this.fun,
      this.commentFun,
      required this.commentValue,
      this.fun3,
      required this.savedValue,
      required this.saveIcon,
        required this.commentIcon});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 25,
      ),
      padding: const EdgeInsets.all(14.0),
      height: size.height * 0.40,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey, //New
            blurRadius: 7.0,
          )
        ],
        image: DecorationImage(
          image: NetworkImage(postModel.postImg!),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black87.withOpacity(0.2), BlendMode.darken),
        ),
      ),
      child: Column(
        children: [
          PostHeaderWidget(
            name: postModel.name!,
            profileImg: postModel.image!,
            dateTime: postModel.dateTime!,
            index: index,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PostFooterWidget(
                context: context,
                icon: loveIcon,
                value: likeValue,
                fun: likeFun,
                color: loveColor,

              ),
              PostFooterWidget(
                context: context,
                icon: commentIcon,
                value: commentValue,
                color: commentColor,
                fun: commentFun,

              ),
              PostFooterWidget(
                context: context,
                icon: saveIcon,
                value: savedValue,
                fun: fun3,
                color: savedColor,

              ),
            ],
          )
        ],
      ),
    );
  }
}
