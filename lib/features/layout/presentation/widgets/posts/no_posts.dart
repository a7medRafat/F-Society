import 'package:flutter/material.dart';

class NoPostsWidget extends StatefulWidget {

  const NoPostsWidget({super.key});

  @override
  State<NoPostsWidget> createState() => _NoPostsWidgetState();
}

class _NoPostsWidgetState extends State<NoPostsWidget> {
  @override
  Widget build(BuildContext context) {
    return  Center(child:  Text('no posts yet !',style: Theme.of(context).textTheme.titleSmall));

  }
}
