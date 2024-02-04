import 'package:flutter/material.dart';

class MyDialog {
  Future<dynamic> show(context, final fun) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
              "Log Out",
              style: TextStyle(color: Colors.red, fontSize: 18)),
          content:  Text("are you really want to Log Out ? ",
              style: Theme.of(context).textTheme.titleSmall),
          actions: <Widget>[
            TextButton(
              onPressed: fun,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(14),
                child: const Text("Yes",style: TextStyle(color: Colors.redAccent),),
              ),
            ),
          ],
        ),
      );
}
