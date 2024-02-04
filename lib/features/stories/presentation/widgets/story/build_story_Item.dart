import 'package:flutter/cupertino.dart';
import '../../../../../config/style/app_colors.dart';

class BuildStoryItem extends StatelessWidget {
  const BuildStoryItem({super.key, required this.index, required this.img});

  final int index;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      width: 56.0,
      margin: EdgeInsets.only(
        left: 30.0,
        right: index == 4 ? 30.0 : 0.0,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1.5, color: AppColors().storyBorder),
        image: DecorationImage(
          image: NetworkImage(img),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
