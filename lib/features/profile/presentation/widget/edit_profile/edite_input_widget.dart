import 'package:flutter/cupertino.dart';

import '../../../../../core/utiles/text_field.dart';

class EditeInputWidget extends StatelessWidget {

   EditeInputWidget({super.key, required this.nameCon, required this.bioCon, required this.profileK, required this.phoneCon});
  final TextEditingController nameCon;
  final TextEditingController bioCon;
  final TextEditingController phoneCon;
  final GlobalKey<FormState> profileK;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: profileK,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            DefaultField(
              controller: nameCon,
              hint: 'your name',
              isPassword: false,
              textInputType: TextInputType.name,
              validation: (value) {
                if (value.isEmpty) {
                  return ' name is required';
                }
              }
            ),
            SizedBox(height: 5),
            DefaultField(
              controller: bioCon,
              hint: 'your bio',
              isPassword: false,
              textInputType: TextInputType.name,
                validation: (value) {
                  if (value.isEmpty) {
                    return ' bio is required';
                  }
                }
            ),
            SizedBox(height: 5),
            DefaultField(
              controller: phoneCon,
              hint: 'phone number',
              isPassword: false,
              textInputType: TextInputType.name,
                validation: (value) {
                  if (value.isEmpty) {
                    return ' phone is required';
                  }
                }

            ),
          ],
        ),
      ),
    );
  }
}
