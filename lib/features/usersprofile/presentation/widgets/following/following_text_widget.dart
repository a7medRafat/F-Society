import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FollowingTextWidget extends StatelessWidget {

  const FollowingTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text('Following',
          style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
