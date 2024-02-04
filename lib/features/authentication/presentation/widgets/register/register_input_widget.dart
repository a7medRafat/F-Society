import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/core/utiles/strings.dart';
import '../../../../../config/style/icons_broken.dart';
import '../../../../../core/utiles/text_field.dart';

class RegisterInputWidget extends StatefulWidget {
  RegisterInputWidget(
      {super.key,
      required this.c1,
      required this.c2,
      required this.c3,
      required this.c4,
      required this.fKey});

  @override
  State<RegisterInputWidget> createState() => _RegisterInputWidgetState();
  final TextEditingController c1;
  final TextEditingController c2;
  final TextEditingController c3;
  final TextEditingController c4;
  final GlobalKey<FormState> fKey;
  bool isPassword = true;
}

class _RegisterInputWidgetState extends State<RegisterInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.fKey,
      child: Column(
        children: [
          DefaultField(
            controller: widget.c1,
            hint: 'user name',
            prefixIcon: const Icon(IconBroken.User),
            isPassword: false,
            textInputType: TextInputType.name,
            validation: (value) {
              if (value.isEmpty) {
                return ' name is required';
              }
            },
          ),
          DefaultField(
            controller: widget.c2,
            hint: 'email',
            prefixIcon: const Icon(IconBroken.Message),
            isPassword: false,
            textInputType: TextInputType.emailAddress,
            validation: (value) {
              if (value.isEmpty) {
                return ' email address is required';
              }
              AppStrings().emailPattern;
              RegExp regex = RegExp(AppStrings().emailPattern);
              if (!regex.hasMatch(value)) {
                return AppStrings().emailReturn;
              }
            },
          ),
          DefaultField(
            controller: widget.c3,
            hint: 'password',
            isPassword: widget.isPassword,
            prefixIcon: const Icon(IconBroken.Password),
            suffixPressed: () {
              setState(() {
                widget.isPassword = !widget.isPassword;
              });
            },
            suffixIcon: widget.isPassword ? IconBroken.Show : IconBroken.Hide,
            textInputType: TextInputType.visiblePassword,
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
          DefaultField(
            controller: widget.c4,
            hint: 'phone',
            prefixIcon: Icon(IconBroken.Call),
            isPassword: false,
            textInputType: TextInputType.phone,
            validation: (value) {
              if (value.isEmpty) {
                return ' phone is required';
              }
            },
          ),
        ],
      ),
    );
  }
}
