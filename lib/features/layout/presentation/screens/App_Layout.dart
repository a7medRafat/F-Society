import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/nav_widget.dart';

class AppLayout extends StatelessWidget {
  AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Nav()
    );
  }
}
