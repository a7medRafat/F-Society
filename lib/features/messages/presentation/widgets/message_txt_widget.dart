import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageTextWidget extends StatelessWidget {

  const MessageTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text('Messages',
          style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
