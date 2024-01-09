import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation {

  void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );

  void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
          (Route) => false);
}