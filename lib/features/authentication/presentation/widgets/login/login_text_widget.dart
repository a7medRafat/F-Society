import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginTextWidget extends StatelessWidget {

  const LoginTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text('Login',
            style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(height: size.height * 0.04),
        SizedBox(height: 10),
      ],
    );
  }
}
