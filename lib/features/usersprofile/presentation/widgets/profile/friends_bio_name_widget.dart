import 'package:flutter/material.dart';
import '../../../../../core/local_storage/hive_keys.dart';
import '../../../../../core/local_storage/user_storage.dart';
import '../../../../../config/style/app_colors.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

class FriendsNameAndBioWidget extends StatelessWidget {
  const FriendsNameAndBioWidget({
    super.key,
    required this.name,
    required this.bio,
  });

  final String name;
  final String bio;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(name, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 5),
          Text('@ $bio',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors().rectangle2)),
        ],
      ),
    );
  }
}
