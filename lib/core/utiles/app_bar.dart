import 'package:flutter/material.dart';

class MyAppBar {
   appBar({required final String text,
   required BuildContext context,
   final Function()? fun , Function()? optionalFun}) =>
      AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: fun,
            child: Text(
              text,
              style: const TextStyle(color: Colors.deepPurple),
            ),
          )
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      );
}
