import 'package:flutter/material.dart';
import '../../../../../core/utiles/text_field.dart';

class CommentInput extends StatefulWidget {
  const CommentInput({super.key, required this.controller, required this.sendCommentFun});

  final TextEditingController controller;
  final Function() sendCommentFun;

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  Color iconColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DefaultField(
          onChanged: (text) {
            setState(() {
              print('ssss');
              iconColor = text.isNotEmpty ? Colors.blueAccent : Colors.grey;
            });
          },
          borderSide: false,
          controller: widget.controller,
          hint: 'write a comment',
          isPassword: false,
          suffixIcon: Icons.arrow_forward,
          suffixIconColor: iconColor,
          suffixPressed: widget.sendCommentFun,
          filled: true,
          filledColor: const Color(0xffefefef).withOpacity(0.4),
          textInputType: TextInputType.text,
          validation: (value) {
            if (value.isEmpty) {
              return 'required';
            }
          }),
    );
  }
}