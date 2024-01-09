import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/local_storage/hive_keys.dart';
import '../../../../../core/local_storage/user_storage.dart';
import 'package:fsociety/injuctoin_container.dart' as di;

class StoryHeaderWidget extends StatelessWidget {
  final int index;
  // final StoryModel storyModel;

  const StoryHeaderWidget({
    super.key,
    required this.index,
  });

  get di => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.image!),
                radius: 20,
              ),
              const SizedBox(width: 15),
              Text(
                di.sl<UserStorage>().getData(id: HiveKeys.currentUser)!.name!,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              ),
              SizedBox(width: 15),
              Text(DateFormat('kk:mm:a').format(DateTime.now()).toString()
                ,style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black38,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 15,
                    ),
                  )))
        ],
      ),
    );
  }
}
