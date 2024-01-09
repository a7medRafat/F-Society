import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class FaceAndGoogleWidget extends StatelessWidget {

  const FaceAndGoogleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.redAccent,
          radius: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/google.png'),
          ),
        ),
        SizedBox(width: 20),
        InkWell(
          onTap: (){},
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/facebook.png'),
            ),
          ),
        ),
      ],
    );
  }
}
