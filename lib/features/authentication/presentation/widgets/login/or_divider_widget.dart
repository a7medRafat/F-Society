import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../config/style/app_colors.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 0.4,
              color: AppColors().rectangle3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('OR',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors().rectangle3)),
          ),
          Expanded(
            child: Container(
              height: 0.4,
              color: AppColors().rectangle3,
            ),
          ),
        ],
      ),
    );
  }
}
