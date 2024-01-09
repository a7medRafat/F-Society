import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsociety/features/messages/data/models/get_all_users.dart';
import '../profile_img.dart';

class MessageDetailHeader extends StatelessWidget {
  final GetAllUsersModel model;
  const MessageDetailHeader({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // the widget we created earlier:
           ProfileImage(
            radius: 35.0,
            img: model.image!,
          ),
          const SizedBox(width: 16.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                model.name!,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 2.0),
              Text(
                'Online',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
