import 'package:flutter/material.dart';
import 'package:fsociety/features/profile/cubit/profile_cubit.dart';
import '../../../../../config/style/icons_broken.dart';

class ImgOrSavedWidget extends StatefulWidget {
  const ImgOrSavedWidget({super.key});

  @override
  State<ImgOrSavedWidget> createState() => _ImgOrSavedWidgetState();
}

class _ImgOrSavedWidgetState extends State<ImgOrSavedWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      ProfileCubit.get(context).changeIndex();
                    });
                  },
                  icon: const Icon(
                    IconBroken.Image,
                    size: 30,
                  )),
            ),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  setState(() {
                    ProfileCubit.get(context).changeIndex;
                  });
                },
                icon: const Icon(
                  IconBroken.Bookmark,
                  size: 30,
                )),
          ),
        ],
      ),
    );
  }
}
