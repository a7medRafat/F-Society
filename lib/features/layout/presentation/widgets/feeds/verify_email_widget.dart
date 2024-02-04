import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/config/style/icons_broken.dart';
import 'package:fsociety/core/mysnackbar/mysnackbar.dart';

class VerifyEmailWidget extends StatefulWidget {
  VerifyEmailWidget({super.key});

  @override
  State<VerifyEmailWidget> createState() => _VerifyEmailWidgetState();
}

class _VerifyEmailWidgetState extends State<VerifyEmailWidget> {
  Color color = Color(0XFFffff9e).withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          color = Color(0XFF7cc0d8).withOpacity(0.6);
          verifyEmail();
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Verify your email',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black)),
              SizedBox(width: 8),
              Icon(
                IconBroken.Info_Circle,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }

  void verifyEmail() {
    FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
      MySnackBar()
          .snackBarMessage(context, 'check your email');
    }).catchError((error) {
      MySnackBar()
          .snackBarMessage(context, error.toString());
      print(error.toString());
    });
  }
}
