import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../config/style/icons_broken.dart';
import '../../../../../config/style/app_colors.dart';
import '../../../../../core/utiles/custom_btn.dart';

class MessageDetailFooter extends StatefulWidget {
  MessageDetailFooter(
      {super.key, this.sendMessage, required this.messageController});

  final TextEditingController messageController;

  // ignore: prefer_typing_uninitialized_variables
  final sendMessage;

  @override
  State<MessageDetailFooter> createState() => _MessageDetailFooterState();
}

class _MessageDetailFooterState extends State<MessageDetailFooter> {
  bool isEmpty = true;

  Color iconColor = Colors.grey.withOpacity(0.2);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 82,
      width: size.width,
      margin: const EdgeInsets.only(
        left: 40.0,
        right: 40.0,
        top: 8.0,
        bottom: 50.0,
      ),
      padding: const EdgeInsets.only(
        left: 32.0,
        right: 16.0,
      ),
      decoration: BoxDecoration(
        color: AppColors().mainColor,
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 25.0,
            color: AppColors().fBlack.withOpacity(0.10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              onChanged: (text) {
                setState(() {
                  iconColor = text.isEmpty
                      ? Colors.grey.withOpacity(0.2)
                      : Colors.white;
                });
              },
              controller: widget.messageController,
              style: Theme.of(context).textTheme.titleSmall,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Write a message...',
                hintStyle: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
          CustomButton(
              onTap: widget.sendMessage,
              child: Icon(
                IconBroken.Send,
                color: iconColor,
              )),
        ],
      ),
    );
  }
}
