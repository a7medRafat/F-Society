import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinearProgressWidget extends StatefulWidget {

  final fun ;
  LinearProgressWidget({super.key,required this.fun});

  @override
  State<LinearProgressWidget> createState() => _LinearProgreesWidgetState();
}

class _LinearProgreesWidgetState extends State<LinearProgressWidget> {


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
          widget.fun;
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
  Widget build(BuildContext context) {
    return Container(
      child:LinearProgressIndicator(
        value: _progressValue,
        backgroundColor: Colors.grey,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }
}
