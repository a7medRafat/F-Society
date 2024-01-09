import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_menu/pie_menu.dart';

class FeedsTextWidget extends StatelessWidget {
  const FeedsTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: InkWell(
          child: Text('Feed', style: Theme.of(context).textTheme.bodyMedium),
        ));
  }
}
