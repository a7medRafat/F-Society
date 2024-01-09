import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/local_storage/hive_keys.dart';
import '../../../../core/local_storage/user_storage.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

class AddPostHeader extends StatelessWidget {
  const AddPostHeader({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withOpacity(0.15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.image!),
            ),
            SizedBox(width: 10),
            Text(
              'what\'s in your mind ',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall,
            ),
            Text(
              '${di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name!} ?',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!.copyWith(
                color: Colors.deepPurple
              ),
            ),
          ],
        ),
      ),
    );
  }
}
