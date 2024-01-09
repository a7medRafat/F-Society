import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:fsociety/features/layout/cubit/feeds_cubit.dart';
import '../../config/style/icons_broken.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

class FocusedMenu {
  Widget focused(context, index) => FocusedMenuHolder(
        onPressed: () {},
        menuWidth: MediaQuery.of(context).size.width * 0.50,
        menuBoxDecoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        duration: const Duration(milliseconds: 5),
        animateMenuItems: true,
        openWithTap: true,
        blurSize: 3.0,
        bottomOffsetHeight: 100,
        menuItemExtent: 45,
        menuItems: <FocusedMenuItem>[
          FocusedMenuItem(
              title: Text('Delete',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 13,
                        color: Colors.white,
                      )),
              trailingIcon:
                  const Icon(IconBroken.Delete, color: Colors.white, size: 20),
              backgroundColor: Colors.redAccent,
              onPressed: () {
                FeedsCubit.get(context)
                    .deletePost(di.sl<FeedsCubit>().postId[index]);
              }),
        ],
        child: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
      );
}
