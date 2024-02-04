import 'package:flutter/material.dart';
import '../../../../../core/local_storage/hive_keys.dart';
import '../../../../../core/local_storage/user_storage.dart';
import '../../../../../config/style/app_colors.dart';
import 'package:fsociety/app/injuctoin_container.dart' as di;

class NameAndBioWidget extends StatelessWidget {
  const NameAndBioWidget({super.key,});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name!,
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 5),
          Text(
              '@${di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.bio}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors().rectangle2)),
        ],
      ),
    );
  }
}
