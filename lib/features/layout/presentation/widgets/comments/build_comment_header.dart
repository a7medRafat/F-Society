import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../config/style/app_colors.dart';

class CommentHeader extends StatelessWidget {

  const CommentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: 5,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppColors().rectangle3,
            ),
          ),
        ),
        Text('comments',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: AppColors().rectangle2)),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: 0.2,
            color: Colors.grey.withOpacity(0.3),
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
