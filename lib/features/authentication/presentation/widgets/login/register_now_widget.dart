import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/navigation/navigation.dart';
import '../../screens/register_screen/register_screen.dart';

class RegisterNowWidget extends StatelessWidget {


  const RegisterNowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black, fontSize: 12),
        ),
        TextButton(
            onPressed:(){
              Navigation().navigateTo(context, RegisterScreen());
            },
            child: const Text('Register Now')),
      ],
    );
  }
}
