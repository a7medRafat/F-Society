import 'package:flutter/material.dart';
import 'package:fsociety/core/navigation/navigation.dart';
import 'package:fsociety/features/stories/cubit/story_cubit.dart';
import 'package:fsociety/features/stories/presentation/screens/story_screen.dart';
import '../../../../../config/style/app_colors.dart';
import 'package:fsociety/app/injuctoin_container.dart'as di;

class AddStoryButton extends StatelessWidget {

  const AddStoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
      child: Container(
          height: 56.0,
          width: 56.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors().grediant,
            boxShadow: [
              BoxShadow(
                blurRadius: 10.0,
                offset: const Offset(0, 0),
                color: AppColors().k3Pink.withOpacity(0.52),
              ),
            ],
          ),
          child: IconButton(onPressed: (){
            di.sl<StoryCubit>().getStoryImg().then((value) {
              Navigation().navigateTo(context, const StoryScreen());
            });
          },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),)
      ),
    );
  }
}
