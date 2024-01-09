import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoadingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(

        color: Colors.black,strokeWidth: 3.0,)
    );
  }
}
