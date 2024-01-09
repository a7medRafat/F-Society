import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';

import '../../../../../config/style/icons_broken.dart';
import '../../../../../core/utiles/app_colors.dart';

class ImgPiker extends StatelessWidget {

  const ImgPiker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return IconButton(
            onPressed: () {
            ProfileCubit.get(context).getProfileImg();
            },
            icon: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors().mainColor
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(IconBroken.Camera),
                )));
      },
    );
  }
}
