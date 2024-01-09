import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDialog {
  Future<dynamic> show(context , final fun) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Sign out" , style: TextStyle(color: Colors.red,fontSize: 18)),
          content: const Text("are you really want to sign out ? " , style: TextStyle(color: Colors.black87,fontSize: 13)),
          actions: <Widget>[
            TextButton(
              onPressed: fun,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white38,
                  borderRadius: BorderRadius.circular(20)
                ),
                padding: const EdgeInsets.all(14),
                child: const Text("yeah"),
              ),
            ),
          ],
        ),
      );
}
