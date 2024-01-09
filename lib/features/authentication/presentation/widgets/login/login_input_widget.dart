import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/core/utiles/app_colors.dart';
import 'package:fsociety/core/utiles/sizes.dart';
import 'package:fsociety/core/utiles/strings.dart';
import '../../../../../config/style/icons_broken.dart';
import '../../../../../core/utiles/text_field.dart';

class LoginInputWidget extends StatefulWidget {


  LoginInputWidget(
      {super.key,
      required this.controller1,
      required this.controller2,
      required this.fKey
      });

  @override
  final TextEditingController controller1;
  final TextEditingController controller2;
  final GlobalKey<FormState> fKey;
  bool isPassword = true;
  State<LoginInputWidget> createState() => _LoginInputWidgetState();
}

class _LoginInputWidgetState extends State<LoginInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.fKey,
      child: Column(
        children: [
          DefaultField(
            controller: widget.controller1,
            hint: 'e-mail',
            prefixIcon: Icon(IconBroken.Message),
            isPassword: false,
            textInputType: TextInputType.emailAddress,
            validation: (value) {
              if (value.isEmpty) {
                return ' email address is required';
              }
              String pattern = r'\w+@\w+\.\w+';
              RegExp regex = RegExp(pattern);
              if (!regex.hasMatch(value))
                return 'Invalid E-mail Address format.';
            },
          ),
          DefaultField(
            controller: widget.controller2,
            hint: 'password',
            prefixIcon: Icon(IconBroken.Lock),
            suffixIcon:  widget.isPassword? IconBroken.Show : IconBroken.Hide ,
            suffixPressed: (){
              setState(() {
                widget.isPassword = !widget.isPassword;
              });
            },
            isPassword: widget.isPassword ? true : false,
            textInputType: TextInputType.emailAddress,
            validation: (value) {
              if (value.isEmpty) {
                return ' password is required';
              }
             AppStrings().passwordPattern;
              RegExp regex = RegExp(AppStrings().passwordPattern);
              if (!regex.hasMatch(value)) {
                return AppStrings().passwordReturn;
              }
            },
          ),
        ],
      ),
    );
  }
}
