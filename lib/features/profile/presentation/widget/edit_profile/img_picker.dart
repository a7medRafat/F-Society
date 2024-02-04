import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/utiles/loading_widget.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;
import '../../../../../config/style/icons_broken.dart';
import '../../../../../config/style/app_colors.dart';

class ImgPikerOrDone extends StatelessWidget {
  const ImgPikerOrDone({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (di.sl<ProfileCubit>().uploading == true) {
          return const Padding(
            padding: EdgeInsets.only(top: 10),
            child: SizedBox(
                child: LoadingWidget()),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            di.sl<ProfileCubit>().profileImg == null
                ? IconButton(
                    onPressed: () {
                      ProfileCubit.get(context).getProfileImg();
                    },
                    icon: containerDecoration(IconBroken.Camera))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            di.sl<ProfileCubit>().uploadProfileImg();
                          },
                          icon: containerDecoration(BootstrapIcons.check)),
                      const SizedBox(width: 10),
                      IconButton(
                          onPressed: () {
                            di.sl<ProfileCubit>().clearProfileImg();
                          },
                          icon: containerDecoration(BootstrapIcons.x)),
                    ],
                  )
          ],
        );
      },
    );
  }

  containerDecoration(IconData icon) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors().mainColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon),
      ));
}
