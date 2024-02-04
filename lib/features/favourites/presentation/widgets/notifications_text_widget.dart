import 'package:flutter/material.dart';

class NotificationsTextWidget extends StatelessWidget {

  const NotificationsTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text('Notifications',
          style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
