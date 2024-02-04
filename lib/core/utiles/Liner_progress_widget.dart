import 'package:flutter/material.dart';

class LinearLoading extends StatelessWidget {


  const LinearLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
      color: Colors.black87,
      minHeight: 2,
    );
  }
}


