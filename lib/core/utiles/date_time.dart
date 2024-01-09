import 'dart:async';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TimeAgoWidget extends StatefulWidget {

  final Timestamp timestamp;

  TimeAgoWidget({required this.timestamp});

  @override
  _TimeAgoWidgetState createState() => _TimeAgoWidgetState();
}

class _TimeAgoWidgetState extends State<TimeAgoWidget> {
  late DateTime dateTime;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    dateTime = widget.timestamp.toDate();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        dateTime = widget.timestamp.toDate();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String timeAgo = timeago.format(dateTime, locale: 'en');
    return Text(timeAgo);
  }
}
