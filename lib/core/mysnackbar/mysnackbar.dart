import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/config/style/app_colors.dart';

class MySnackBar {
  snackBarMessage(context, String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 80,
              left: 10,
              right: 10),
          behavior: SnackBarBehavior.floating,
          padding: const EdgeInsets.all(20),
          backgroundColor: AppColors().mainColor,
          elevation: 2,
          content: Text(
            msg,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: AppColors().fBlack),
          )));
}

