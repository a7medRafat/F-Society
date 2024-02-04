import 'package:flutter/material.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import 'package:fsociety/features/profile/presentation/widget/profile/gride_widget.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

class ProfileSavedWidget extends StatelessWidget {
  const ProfileSavedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (di.sl<ProfileCubit>().mySaved.isEmpty)
          SizedBox(
              height: 200,
              child: Center(
                  child: Text(
                'No Saved',
                style: Theme.of(context).textTheme.titleSmall,
              ))),
        GridWidget(
            length: di.sl<ProfileCubit>().mySaved.length,
            listName: di.sl<ProfileCubit>().mySaved)
      ],
    );
  }
}
