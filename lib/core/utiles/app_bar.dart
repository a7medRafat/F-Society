import 'package:flutter/material.dart';


class MyAppBar {
  appBar(
          {final String? text,
          final Color? textColor,
          required BuildContext context,
          final Function()? fun}) =>
      AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: fun,
            child: Text(
              text ?? '',
              style: TextStyle(color: textColor),
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      );

  sliverBar(
          {required context,
          required double height,
          required Widget? backGround,
          Function()? actionFun,
          String? actionText,
          Color? textColor,
          }) =>
      SliverAppBar(
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: actionFun,
            child: Text(
              actionText ?? '',
              style: TextStyle(color: textColor),
            ),
          ),
        ],
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60))),
        expandedHeight: MediaQuery.of(context).size.height * height,
        pinned: true,
        floating: true,
        snap: false,
        flexibleSpace: FlexibleSpaceBar(background: backGround),
      );
}
