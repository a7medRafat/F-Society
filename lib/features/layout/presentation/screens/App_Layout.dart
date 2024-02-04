import 'package:flutter/material.dart';
import 'package:fsociety/core/notification/messaging.dart';
import '../widgets/nav_widget.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  void initState() {
    FcmMessaging().onMessage();
    FcmMessaging().onMessageOpenedApp(context);
    FcmMessaging().initialMessage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Nav());
  }
}
