import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FollowersTextWidget extends StatelessWidget {

  const FollowersTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text('Followers',
          style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
