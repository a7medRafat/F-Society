import 'dart:async';
import 'package:flutter/material.dart';

class LinearProgressWidget extends StatefulWidget {

  const LinearProgressWidget({super.key});

  @override
  State<LinearProgressWidget> createState() => _LinearProgressWidgetState();
}

class _LinearProgressWidgetState extends State<LinearProgressWidget> {


  double _progressValue = 0.0;
  void _startLoading() {
    const duration = Duration(seconds: 5);
    // Use a Timer to update the progress value over time
    Timer.periodic(Duration(milliseconds: (duration.inMilliseconds / 100).round()), (timer) {
      setState(() {
        if (_progressValue < 1.0) {
          _progressValue += 0.01;
        } else {
          timer.cancel();
          setState(() {
            Navigator.pop(context);
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _progressValue,
      backgroundColor: Colors.grey,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }
}
