import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsociety/core/utiles/app_colors.dart';
import 'package:fsociety/core/utiles/loading_widget.dart';
import 'package:fsociety/features/layout/cubit/feeds_cubit.dart';
import 'package:fsociety/features/profile/presentation/widget/profile/profile_gallery_widget.dart';
import 'package:fsociety/features/profile/presentation/widget/profile/profile_saved_widget.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

class Toggle extends StatefulWidget {
  const Toggle({Key? key}) : super(key: key);

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  final Color kDarkBlueColor = AppColors().rectangle1;

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: AppinioAnimatedToggleTab(
              duration: const Duration(milliseconds: 150),
              offset: 0.25,
              callback: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              tabTexts: const [
                'gallery',
                'saved',
              ],
              height: 40,
              width: 300,
              boxDecoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              animatedBoxDecoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFc3d2db).withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(2, 2),
                  ),
                ],
                color: kDarkBlueColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              activeStyle: TextStyle(
                fontSize: 14,
                color: AppColors().rectangle2,
                fontWeight: FontWeight.w600,
              ),
              inactiveStyle: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          currentIndex == 0
              ? const ProfileGalleryWidget()
              : const ProfileSavedWidget()
        ],
      ),
    );
  }
}
